require('nvim_config.packer')
require('nvim_config.set')
require('nvim_config.remap')

vim.cmd.colorscheme "catppuccin-frappe"

vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

vim.api.nvim_set_option("clipboard", "unnamedplus")
