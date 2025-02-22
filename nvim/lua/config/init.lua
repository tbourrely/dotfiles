require('config.lazy')
require('config.set')
require('config.remap')
require('config.terminal')

vim.cmd("colorscheme rose-pine")

vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

vim.api.nvim_set_option("clipboard", "unnamedplus")

vim.o.updatetime = 250
