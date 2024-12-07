return {
	{ 'tpope/vim-commentary' },
	{ 'tpope/vim-surround' },
	{ 'raimondi/delimitmate' },
	{ 'tpope/vim-sleuth' },
	{ 'junegunn/vim-easy-align' },
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("ibl").setup {
				indent = { char = ">" }
			}
		end
	},
}
