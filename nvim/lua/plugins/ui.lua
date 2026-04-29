return {
	{ "shortcuts/no-neck-pain.nvim", version = "*", opts = { width = 150, autocmds = { enableOnVimEnter = true } } },
	{ 'nvim-lualine/lualine.nvim',   config = true, opts = { theme = 'dracula', sections = { lualine_a = { { 'filename', path=1 } } } } },
}
