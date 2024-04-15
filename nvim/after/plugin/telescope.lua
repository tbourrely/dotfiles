local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if vim.opt.foldmethod:get() == "expr" then
      vim.schedule(function()
        vim.opt.foldmethod = "expr"
      end)
    end
  end,
})
