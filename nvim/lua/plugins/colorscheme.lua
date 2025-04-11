return {
	{"catppuccin/nvim", name = "catppuccin"},
	{ 
		"rose-pine/neovim", 
		name = "rose-pine",
		config = function()
			vim.cmd("colorscheme rose-pine-moon")
		end
	}
}
