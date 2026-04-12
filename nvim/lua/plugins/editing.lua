return {
	{ 'tpope/vim-surround' },
	{ 'm4xshen/autoclose.nvim' },
	{
		'nvim-mini/mini.indentscope',
		version = '*',
		config = function()
			require('mini.indentscope').setup({
				draw = { animation = require('mini.indentscope').gen_animation.none() }
			})
		end
	},
	-- auto indent guessing magic
	-- { 'tpope/vim-sleuth' },
	-- { 'junegunn/vim-easy-align' },
}
