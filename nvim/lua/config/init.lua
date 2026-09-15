vim.keymap.set("n", " ", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = " "

require('config.lazy')
require('config.set')
require('config.remap')
require('config.terminal')
require('config.filetypes')
require('config.netrw')

vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

vim.api.nvim_set_option("clipboard", "unnamedplus")

vim.o.updatetime = 250
