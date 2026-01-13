return {
	{
		"mfussenegger/nvim-dap",
		keys = {
			{ "<leader>b",  function() require('dap').toggle_breakpoint() end },
			{ "<leader>dc", function() require('dap').continue() end },
			{ "<leader>dr", function() require('dap').repl.open() end },
			{ "<leader>dj", function() require('dap').step_into() end },
			{ "<leader>dk", function() require('dap').step_out() end },
			{ "<leader>dl", function() require('dap').step_over() end },
			{ "<leader>dh", function()
				require('dap.ui.widgets').hover()
			end },
			{ "<leader>dp", function()
				require('dap.ui.widgets').preview()
			end },
			{ "<leader>df", function()
				local widgets = require('dap.ui.widgets')
				widgets.centered_float(widgets.frames)
			end },
			{ "<leader>ds", function()
				local widgets = require('dap.ui.widgets')
				widgets.centered_float(widgets.scopes)
			end },
		},
		config = function()
			-- require('dap').setup()

			--- Gets a path to a package in the Mason registry.
			--- Prefer this to `get_package`, since the package might not always be
			--- available yet and trigger errors.
			---@param pkg string
			---@param path? string
			local function get_pkg_path(pkg, path)
				pcall(require, 'mason')
				local root = vim.env.MASON or (vim.fn.stdpath('data') .. '/mason')
				path = path or ''
				local ret = root .. '/packages/' .. pkg .. '/' .. path
				return ret
			end

			require('dap').adapters['pwa-node'] = {
				type = 'server',
				host = 'localhost',
				port = '${port}',
				executable = {
					command = 'node',
					args = {
						get_pkg_path('js-debug-adapter', '/js-debug/src/dapDebugServer.js'),
						'${port}',
					},
				},
			}

			for _, language in ipairs({ "typescript", "javascript" }) do
				require("dap").configurations[language] = {
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach",
						port = 9229,
						restart = true,
						sourceMaps = true,
						stopOnEntry = false,
						protocol = "inspector",
						cwd = "${workspaceFolder}",
						-- continueOnAttach = true,
						autoAttachChildProcesses = true,
						console = "integratedTerminal",
						-- internalConsoleOptions = "neverOpen",
					},
				}
			end
		end
	},
	-- {
	-- 	"mxsdev/nvim-dap-vscode-js",
	-- 	dependencies = { "mfussenegger/nvim-dap" },
	-- 	init = function()
	-- 		require("dap-vscode-js").setup({
	-- 			adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
	-- 		})
	-- 		--
	-- 		for _, language in ipairs({ "typescript", "javascript" }) do
	-- 			require("dap").configurations[language] = {
	-- 				{
	-- 					type = "pwa-node",
	-- 					request = "attach",
	-- 					name = "Attach",
	-- 					port = 9229,
	-- 					cwd = "${workspaceFolder}",
	-- 					continueOnAttach = true,
	-- 					console = "integratedTerminal",
	-- 					internalConsoleOptions = "neverOpen",
	-- 				},
	-- 			}
	-- 		end
	-- 	end
	-- },
	{
		"microsoft/vscode-js-debug",
		lazy = true,
		build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
	},
	{
		"leoluz/nvim-dap-go",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			require('dap-go').setup()
		end
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			require("dapui").setup()
			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open({ reset = true })
			end
			dap.listeners.before.event_terminated["dapui_config"] = dapui.close
			dap.listeners.before.event_exited["dapui_config"] = dapui.close
		end
	}
}
