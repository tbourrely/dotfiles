local api = vim.api

vim.keymap.set('t', '<esc>', "<C-\\><C-n>")      

vim.api.nvim_create_autocmd("TermEnter", {
  callback = function()
    vim.cmd("setlocal signcolumn=no")
  end
})

vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
    vim.cmd("startinsert")
  end
})

vim.keymap.set("n", "<leader>st", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 5)
end)

vim.keymap.set("n", "<leader>vt", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("L")
end)
