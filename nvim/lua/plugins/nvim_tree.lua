return {
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		keys = {
			{ "<leader>ft", "<cmd>NvimTreeToggle<cr>", desc = "nvim-tree" },
		},
		config = function()
			require("nvim-tree").setup({
				update_focused_file = { enable = true },
				view = { adaptive_size = true, width = 30 },
			})
		end,
	},
}
