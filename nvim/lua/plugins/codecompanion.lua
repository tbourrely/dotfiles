ollama_model = "codellama:7b" -- the ollama model to run

return {
	{
		"olimorris/codecompanion.nvim",
		enabled = function()
			return os.getenv("CODECOMPANION_AI_ENDPOINTS_API_KEY") ~= nil or os.getenv("CODECOMPANION_OLLAMA") ~= nil
		end,
		init = function()
			local is_already_running_fn = function()
				local handle = io.popen("ollama ps | grep -c " .. ollama_model)
				local result = handle:read("*a")
				handle:close()
				return tonumber(result)
			end

			local notify = function(msg)
				vim.defer_fn(function()
					vim.notify(msg)
				end, 500)
			end

			if os.getenv("CODECOMPANION_OLLAMA") ~= nil then
				if is_already_running_fn() == 1 then
					notify("ollama " .. ollama_model .. " is already running")
				else
					os.execute("ollama run " .. ollama_model .. " ''" )
					notify("codellama started")
				end
			end
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = function()
			active_adapter = ""
			adapters = {}

			if os.getenv("CODECOMPANION_AI_ENDPOINTS_API_KEY") ~= nil then
				active_adapter = "ovhcloud_ai_endpoint"
				adapters[active_adapter] = function()
					return require("codecompanion.adapters").extend("openai_compatible", {
						env = {
							url = "https://llama-3-3-70b-instruct.endpoints.kepler.ai.cloud.ovh.net/api/openai_compat",
							api_key = "CODECOMPANION_AI_ENDPOINTS_API_KEY",
						},
						schema = {
							model = {
								default = "Meta-Llama-3_3-70B-Instruct",
							},
						},
					})
				end
			end

			if os.getenv("CODECOMPANION_OLLAMA") ~= nil then
				active_adapter = "ollama_codellama_7b"
				adapters[active_adapter] = function()
					return require("codecompanion.adapters").extend("ollama", {
						name = adapter,
						schema = {
							model = {
								default = ollama_model,
							},
							num_ctx = {
								default = 16384,
							},
							num_predict = {
								default = -1,
							},
						},
					})
				end
			end

			return {
				adapters = adapters,
				display = {
					chat = {
						window = { position = "right" },
					},
					action_palette = {
						provider = "telescope",
					},
				},
				strategies = {
					chat = {
						adapter = active_adapter,
						slash_commands = {
							["workspace"] = {
								opts = { provider = "telescope" },
							},
							["symbols"] = {
								opts = { provider = "telescope" },
							},
							["help"] = {
								opts = { provider = "telescope" },
							},
							["buffer"] = {
								opts = { provider = "telescope" },
							},
							["file"] = {
								opts = { provider = "telescope" },
							},
						},
					},
					inline = {
						adapter = active_adapter,
						keymaps = {
							accept_change = {
								modes = { n = "ga" },
								description = "Accept the suggested change",
							},
							reject_change = {
								modes = { n = "gu" },
								description = "Reject the suggested change",
							},
						},
					},
				},
				opts = {
					log_level = "DEBUG",
				},
			}
		end,
		keys = {
			{ '<leader>ct', "<cmd>CodeCompanionChat Toggle<cr>", desc = "toggle chat" },
			{ 'ga', "<cmd>CodeCompanionChat Add<cr>", mode = {"v"}, desc = "add code to chat" },
			{ '<leader>ca', "<cmd>CodeCompanionActions<cr>", mode = {"n", "v"}, desc = "toggle actions" },
		},
	},
}
