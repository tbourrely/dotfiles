return {
	'stevearc/conform.nvim',
	opts = {
		-- Define your formatters
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "black" },
			javascript = { "prettierd", "prettier", stop_after_first = true },
			rust = { "rustfmt", lsp_format = "fallback" },
			go = { "gofmt", "goimports" },
		},
		-- Set default options
		default_format_opts = {
			lsp_format = "fallback",
		},
		-- Set up format-on-save
		format_on_save = { timeout_ms = 500 },
	},
}
