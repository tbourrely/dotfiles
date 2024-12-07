return {
	'mechatroner/rainbow_csv',
	init = function()
		vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
			command = "set filetype=csv_semicolon",
			pattern = { "*.csv" },
		})
	end
}
