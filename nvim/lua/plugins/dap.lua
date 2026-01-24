return {
	{
		"mfussenegger/nvim-dap",
		keys = {
			{ "<leader>b",  function() require('dap').toggle_breakpoint() end },
			{ "<leader>dc", function() require('dap').continue() end },
			{ "<leader>ds", function() require('dap').disconnect() require('dap').close() end },
			{ "<leader>dj", function() require('dap').step_into() end },
			{ "<leader>dk", function() require('dap').step_out() end },
			{ "<leader>dl", function() require('dap').step_over() end },
			{ "<leader>dvo", function() vim.cmd('DapViewOpen') end },
			{ "<leader>dvc", function() vim.cmd('DapViewClose') end },
		},
		config = function()
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
						autoAttachChildProcesses = true,
						console = "integratedTerminal",
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
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			require('dap-go').setup()
		end
	},
	{
		"igorlfs/nvim-dap-view",
		dependencies = { "mfussenegger/nvim-dap" },
	}
}
