return {
	'github/copilot.vim',
	enabled = function()
		return os.getenv("COPILOT_ENABLED") ~= nil
	end,
	init = function()
		-- disable copilot for everything by default
		-- enable for chosen filetypes
		vim.g['copilot_filetypes'] = {
			['*'] = false,
			['go'] = true,
			['yaml'] = true,
			['markdown'] = true,
		}
	end
}
