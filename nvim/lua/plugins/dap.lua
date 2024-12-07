return {
	{
		"mfussenegger/nvim-dap",
		keys = {
			{ "<leader>b", function() require('dap').toggle_breakpoint() end },
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
		}
	},
	{
		"mxsdev/nvim-dap-vscode-js",
		dependencies = {"mfussenegger/nvim-dap"},
		init = function()
			require("dap-vscode-js").setup({
				adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, 
			})
--
			for _, language in ipairs({ "typescript", "javascript" }) do
				require("dap").configurations[language] = {
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach",
						port = 9229,
						cwd = "${workspaceFolder}",
						continueOnAttach = true,
						console = "integratedTerminal",
						internalConsoleOptions = "neverOpen",
					},
				}
			end
		end
	},
	{
		"microsoft/vscode-js-debug",
		lazy = true,
		build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out" 
	},
	{
		"leoluz/nvim-dap-go",
		dependencies = {"mfussenegger/nvim-dap"},
		config = function()
			require('dap-go').setup()
		end
	}
}
