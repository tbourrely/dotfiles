return {
	{
		"mason-org/mason.nvim",
		dependencies = {
			"mason-org/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					'ts_ls',
					'eslint',
					'gopls',
					'bashls',
					'golangci_lint_ls',
					'dockerls',
					'yamlls',
					'html',
					'helm_ls',
					'rust_analyzer',
					'pylsp',
					'svelte',
					'cssls',
					'lua_ls'
				},
				automatic_enable = true,
			})

			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true
			})

			-- show diagnostic message on hover
			vim.api.nvim_create_autocmd("CursorHold", {
				buffer = bufnr,
				callback = function()
					local opts = {
						focusable = false,
						close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
						border = 'rounded',
						source = 'always',
						prefix = ' ',
						scope = 'cursor',
					}
					vim.diagnostic.open_float(nil, opts)
				end
			})

			-- jump to definition
			vim.keymap.set('n', 'gd', function()
				vim.lsp.buf.definition()
			end, { buffer = bufnr })

			-- jump to definition in a split
			vim.keymap.set('n', 'gx', function()
				vim.cmd [[split]]
				vim.lsp.buf.definition()
			end, { buffer = bufnr })

			-- jump to defintion in a vertical split
			vim.keymap.set('n', 'gv', function()
				vim.cmd [[vertical botright split]]
				vim.lsp.buf.definition()
			end, { buffer = bufnr })

			-- trigger code actions
			vim.keymap.set('n', 'ga', function()
				vim.lsp.buf.code_action()
			end, { buffer = bufnr })

			-- find references
			vim.keymap.set('n', 'gr', function()
				vim.lsp.buf.references()
			end, { buffer = bufnr })

			-- make lua_ls aware of vim specifics
			vim.lsp.config('lua_ls', {
				on_init = function(client)
					if client.workspace_folders then
						local path = client.workspace_folders[1].name
						if
							path ~= vim.fn.stdpath('config')
							and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
						then
							return
						end
					end

					client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
						runtime = {
							-- Tell the language server which version of Lua you're using (most
							-- likely LuaJIT in the case of Neovim)
							version = 'LuaJIT',
							-- Tell the language server how to find Lua modules same way as Neovim
							-- (see `:h lua-module-load`)
							path = {
								'lua/?.lua',
								'lua/?/init.lua',
							},
						},
						-- Make the server aware of Neovim runtime files
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME
								-- Depending on the usage, you might want to add additional paths
								-- here.
								-- '${3rd}/luv/library'
								-- '${3rd}/busted/library'

								-- Or pull in all of 'runtimepath'.
								-- NOTE: this is a lot slower and will cause issues when working on
								-- your own configuration.
								-- See https://github.com/neovim/nvim-lspconfig/issues/3189
								-- library = {
								--   vim.api.nvim_get_runtime_file('', true),
								-- }
							}
						},
						diagnostics = {
							globals = { 'bufnr' },
						},
					})
				end,
				settings = {
					Lua = {}
				}
			})
		end
	},
	{
		'saghen/blink.cmp',
		dependencies = { 'rafamadriz/friendly-snippets' },
		version = '1.*',
		opts = {
			keymap = { preset = 'default' },
			appearance = {
				nerd_font_variant = 'mono'
			},
			completion = { documentation = { auto_show = true } },
			sources = {
				default = { 'lsp', 'path', 'snippets', 'buffer' },
			},
			fuzzy = { implementation = "prefer_rust_with_warning" }
		},
		opts_extend = { "sources.default" }
	},
	{ 'folke/lsp-colors.nvim' },
}
