return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-textobjects",
				branch = "main",
			},
			{
				'nvim-treesitter/nvim-treesitter-context'
			}
		},
		lazy = false,
		branch = "main",
		build = ":TSUpdate",
		config = function()
			require('nvim-treesitter').install({
				"javascript", "tsx", "typescript",
				"dockerfile", "javascript",
				"typescript", "go", "tsx",
				"html", "css", "yaml",
				"make", "rust", "python",
				"svelte", "jsdoc", "helm"
			})

			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					pcall(vim.treesitter.start)
					vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
					vim.wo[0][0].foldmethod = 'expr'
				end,
			})
		end
	},
	{
		"windwp/nvim-ts-autotag",
		opts = {
			opts = {
				enable_close = true, -- Auto close tags
				enable_rename = true, -- Auto rename pairs of tags
				enable_close_on_slash = false -- Auto close on trailing </
			}
		},
	},
}
