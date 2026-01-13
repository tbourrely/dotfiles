return {
	'nvim-telescope/telescope.nvim',
	lazy = false,
	version = '0.1.5',
	dependencies = { { 'nvim-lua/plenary.nvim' } },
	keys =
	{
		{ '<leader>fg', "<cmd>Telescope live_grep<cr>",              desc = "Live grep" },
		{ '<leader>ff', "<cmd>Telescope find_files hidden=true<cr>", desc = "Find file" },
		{ '<leader>fb', "<cmd>Telescope buffers<cr>",                desc = "Find buffer" },
		{ '<leader>fm', "<cmd>Telescope marks<cr>",                  desc = "Find marks" },
		{ '<leader>fs', "<cmd>Telescope lsp_document_symbols<cr>",   desc = "Find symbols" },
	},
	opts = {
		defaults = {
			path_display = { "smart" },
			-- layout_strategy = "horizontal",
		},
		pickers = {
			find_files = {
				-- theme = "dropdown",
				previewer = false,
			}
		}
	},
}
