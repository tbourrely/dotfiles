return {
	'nvim-telescope/telescope.nvim',
	version = '0.1.5',
	dependencies = { { 'nvim-lua/plenary.nvim' } },
	keys =
	{
		{ '<leader>fg', "<cmd>Telescope live_grep<cr>",  desc = "Live grep" },
		{ '<leader>ff', "<cmd>Telescope find_files<cr>", desc = "Find file" },
		{ '<leader>fb', "<cmd>Telescope buffers<cr>",    desc = "Find buffer" },
		{ '<leader>fm', "<cmd>Telescope marks<cr>",      desc = "Find marks" },
	},
	opts = {
		defaults = {
			path_display = { "smart" },
			layout_strategy = "center",
			layout_config = {
				center = {
					width = { padding = 0 },
					height = { padding = 0 },
				},
			},
		},
	},
}
