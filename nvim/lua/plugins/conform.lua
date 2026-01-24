local js_formatters = { "prettier" }
local enable_ts_imports_manip = {
	["typescript"]=true,
	["typescriptreact"]="true",
}
local add_delete_ts_imports = function()
	if not enable_ts_imports_manip[vim.o.filetype] then
		return
	end
	vim.lsp.buf.code_action({ apply = true, context = { only = { "source.addMissingImports.ts" }, diagnostics = {} } })
	vim.lsp.buf.code_action({ apply = true, context = { only = { "source.removeUnused.ts" }, diagnostics = {} } })
end

return {
	'stevearc/conform.nvim',
	opts = {
		-- Define your formatters
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "black" },
			javascript = js_formatters,
			typescript = js_formatters,
			typescriptreact = js_formatters,
			rust = { "rustfmt", lsp_format = "fallback" },
			go = { "gofmt", "goimports" },
		},
		-- Set up format-on-save
		format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
		async = true,
	},
	init = function()
		vim.api.nvim_create_autocmd("BufWritePre", {
			callback = function()
				add_delete_ts_imports()
				vim.lsp.buf.format()
			end,
		})
	end
}
