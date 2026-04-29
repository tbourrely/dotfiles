local js_formatters = { "biome", "biome-organize-imports" }

return {
	'stevearc/conform.nvim',
	event = { "BufWritePre" },
    keys = {
        {
            "<leader>f",
            function()
                require("conform").format({ async = true, lsp_format = "never" })
            end,
            mode = "",
            desc = "[F]ormat buffer",
        },
    },
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "black" },
			javascript = js_formatters,
			typescript = js_formatters,
			typescriptreact = js_formatters,
			rust = { "rustfmt" },
			go = { "goimports", "gofmt" },
		},
		format_on_save = function(bufnr)
			local ignore_filetypes = { "sql", "yaml" }
			if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
				return
			end

			-- Disable with a global or buffer-local variable
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end

			return { timeout_ms = 500, lsp_format = "never" }
		end,
		async = true,
	},
}
