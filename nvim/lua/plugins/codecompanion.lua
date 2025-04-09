return {
	{
		"olimorris/codecompanion.nvim",
		enabled = function()
			return os.getenv("AI_ENDPOINTS_API_KEY") ~= nil
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			adapters = {
				ovhcloud_ai_endpoint = function()
					return require("codecompanion.adapters").extend("openai_compatible", {
						env = {
							url = "https://llama-3-3-70b-instruct.endpoints.kepler.ai.cloud.ovh.net/api/openai_compat",
							api_key = "AI_ENDPOINTS_API_KEY",
						},
						schema = {
							model = {
								default = "Meta-Llama-3_3-70B-Instruct",
							},
						},
					})
				end,
			},
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
					adapter = "ovhcloud_ai_endpoint",
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
					adapter = "ovhcloud_ai_endpoint",
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
		},
		keys = {
			{ '<leader>ct', "<cmd>CodeCompanionChat Toggle<cr>", desc = "toggle chat" },
			{ 'ga', "<cmd>CodeCompanionChat Add<cr>", mode = {"v"}, desc = "add code to chat" },
			{ '<leader>ca', "<cmd>CodeCompanionActions<cr>", mode = {"n", "v"}, desc = "toggle actions" },
		},
	},
}
