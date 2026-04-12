return {
	'nvim-telescope/telescope.nvim',
	lazy = false,
	version = '0.2.1',
	dependencies = { { 'nvim-lua/plenary.nvim' } },
	keys =
	{
		{ '<leader>fg', "<cmd>Telescope live_grep<cr>",              desc = "Live grep" },
		{ '<leader>ff', "<cmd>Telescope find_files<cr>",             desc = "Find file" },
		{ '<leader>fh', "<cmd>Telescope find_files hidden=true<cr>", desc = "Find file (support hidden)" },
		{ '<leader>fb', "<cmd>Telescope buffers<cr>",                desc = "Find buffer" },
		{ '<leader>fm', "<cmd>Telescope marks<cr>",                  desc = "Find marks" },
		{ '<leader>fs', "<cmd>Telescope lsp_document_symbols<cr>",   desc = "Find symbols" },
		{ '<leader>fd', "<cmd>Telescope diagnostics<cr>",            desc = "Find symbols" },
	},
	opts = {
		defaults = {
			path_display = { "truncate" },
			file_ignore_patterns = { "^.git/" },
			layout_strategy = "center",
			layout_config = {
				center = { width = 0.75, height = 0.5 }
			}
		},
		pickers = {
			find_files = {
				previewer = false,
			},
			diagnostics = {
				layout_strategy = "vertical"
			}
		}
	},
}
