return {
	{ "folke/lsp-colors.nvim" },
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v4.x',
		dependencies = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-path'},
			{'saadparwaiz1/cmp_luasnip'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'hrsh7th/cmp-nvim-lua'},
			{'hrsh7th/cmp-nvim-lsp-signature-help'},

			-- Snippets
			{'L3MON4D3/LuaSnip'},
			{'rafamadriz/friendly-snippets'},
		},
		config = function()
			local lsp = require("lsp-zero")
			lsp.on_attach(function(client, bufnr)
				lsp.default_keymaps({buffer = bufnr})
				vim.keymap.set('n', 'gx', function() 
					vim.cmd [[split]]
					vim.lsp.buf.definition()
				end , {buffer = bufnr})
				vim.keymap.set('n', 'gv', function() 
					vim.cmd [[vertical botright split]]
					vim.lsp.buf.definition()
				end , {buffer = bufnr})
				vim.keymap.set('n', 'ga', function() 
					vim.lsp.buf.code_action()
				end , {buffer = bufnr})
			end)

			require('mason').setup({})
			require('mason-lspconfig').setup({
				ensure_installed = {
					'ts_ls',
					'eslint',
					'gopls',
					'bashls',
					'dockerls',
					'yamlls',
					'html',
					'helm_ls',
					'rust_analyzer',
					'pylsp',
					'svelte',
					'cssls',
				},
				handlers = {
					function(server_name)
						require('lspconfig')[server_name].setup({})
					end,
				},
			})
			require('luasnip.loaders.from_vscode').lazy_load()
			local cmp = require('cmp')
			cmp.setup({
				formatting = lsp.cmp_format(),
				sources = {
					{name = 'nvim_lsp'},
					{name = 'path'},
					{name = 'luasnip'},
				},
				mapping = cmp.mapping.preset.insert(),
				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body)
					end,
				},
			})
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.go",
				callback = function()
					local params = vim.lsp.util.make_range_params()
					params.context = {only = {"source.organizeImports"}}
					-- buf_request_sync defaults to a 1000ms timeout. Depending on your
					-- machine and codebase, you may want longer. Add an additional
					-- argument after params if you find that you have to write the file
					-- twice for changes to be saved.
					-- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
					local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
					for cid, res in pairs(result or {}) do
						for _, r in pairs(res.result or {}) do
							if r.edit then
								local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
								vim.lsp.util.apply_workspace_edit(r.edit, enc)
							end
						end
					end
					vim.lsp.buf.format({async = false})
				end
			})
			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				underline = true
			})
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
		end
	}
}
