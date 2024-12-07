return {
	{
		"mfussenegger/nvim-dap",
		init = function()
			local dap = require('dap')
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
			vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
		end
	},
	{
		"rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
		init = function()
			require("dapui").setup()
			vim.keymap.set("n", "<leader>dt", function() require("dapui").toggle({ reset = true }) end)
		end
	},
	{ "mxsdev/nvim-dap-vscode-js", dependencies = {"mfussenegger/nvim-dap"} },
	{
		"microsoft/vscode-js-debug",
		lazy = true,
		build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out" 
	},
}
