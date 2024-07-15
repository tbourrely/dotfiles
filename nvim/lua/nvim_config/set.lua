local set = vim.opt

set.termguicolors = true
set.cursorline = true
set.number = true
set.relativenumber = true
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.autoread = true

set.foldmethod = "expr"
set.foldexpr = "nvim_treesitter#foldexpr()"
set.foldlevelstart = 6

vim.cmd [[set mouse=a]]
