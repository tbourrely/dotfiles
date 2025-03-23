return {
	{
		'airblade/vim-gitgutter',
		init = function()
			vim.g['gitgutter_sign_priority'] = 0
		end
	},
	{ 'f-person/git-blame.nvim' },
	{ "sindrets/diffview.nvim" },
	{ "tpope/vim-fugitive" },
}
