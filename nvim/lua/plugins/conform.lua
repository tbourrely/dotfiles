local js_formatters = { "prettier" }
local enable_ts_imports_manip = {
	["typescript"] = true,
	["typescriptreact"] = true,
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
		format_on_save = function(bufnr)
			local ignore_filetypes = { "sql", "yaml" }
			if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
				return
			end

			-- Disable with a global or buffer-local variable
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end
			return { timeout_ms = 500, lsp_format = "fallback" }
		end,
		async = true,
	},
	init = function()
		vim.api.nvim_create_autocmd("BufWritePre", {
			callback = function(args)
				add_delete_ts_imports()
				-- vim.lsp.buf.format()
				require("conform").format({ bufnr = args.buf })
			end,
		})

		vim.api.nvim_create_user_command("Format", function(args)
			local range = nil
			if args.count ~= -1 then
				local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
				range = {
					start = { args.line1, 0 },
					["end"] = { args.line2, end_line:len() },
				}
			end
			require("conform").format({ async = true, lsp_format = "fallback", range = range })
		end, { range = true })

		vim.api.nvim_create_user_command("FormatDisable", function(args)
			if args.bang then
				-- FormatDisable! will disable formatting just for this buffer
				vim.b.disable_autoformat = true
			else
				vim.g.disable_autoformat = true
			end
		end, {
			desc = "Disable autoformat-on-save",
			bang = true,
		})

		vim.api.nvim_create_user_command("FormatEnable", function()
			vim.b.disable_autoformat = false
			vim.g.disable_autoformat = false
		end, {
			desc = "Re-enable autoformat-on-save",
		})
	end
}
