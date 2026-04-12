local on_list_handler = function(options)
	print(#options.items)
	if options.items and #options.items > 1 then
		-- Jump to first item. You can do whatever you want here, such as filtering out React d.ts.
		vim.fn.setqflist({}, " ", options) -- Close quicifix list
		vim.cmd("cfirst")            -- Jump to first
	elseif options.items and #options.items == 1 then
		local item = options.items[1]
		vim.fn.setqflist({ item }, "r")
		vim.cmd("cfirst")
	else
		print("No definition found")
	end
end

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
					'tsgo',
					'eslint',
					'biome',
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
				virtual_text = false,
				signs = false,
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
							version = 'LuaJIT',
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
	{
		'neovim/nvim-lspconfig',
		keys = {
			{
				"gd",
				function()
					vim.lsp.buf.definition({
						on_list = on_list_handler,
					})
				end
			},
			{
				"gx",
				function()
					vim.cmd [[split]]
					vim.lsp.buf.definition({
						on_list = on_list_handler,
					})
				end
			},
			{
				"gv",
				function()
					vim.cmd [[vertical botright split]]
					vim.lsp.buf.definition({
						on_list = on_list_handler,
					})
				end
			},
			{
				"<leader>r",
				vim.lsp.buf.rename
			},
			{
				"ga",
				vim.lsp.buf.code_action
			},
			{
				"gr",
				vim.lsp.buf.references
			}
		},
	}
}
