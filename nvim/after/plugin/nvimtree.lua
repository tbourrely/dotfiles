require("nvim-tree").setup {
	update_focused_file = {
		enable = true
	},
	view = { adaptive_size = true, width = 30 }
}
vim.api.nvim_set_keymap('n', '<leader>ft', ':NvimTreeToggle<CR>', {noremap = true, silent = true})
