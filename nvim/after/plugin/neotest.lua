require("neotest").setup({
  adapters = {
    require('neotest-jest')({
      jestCommand = "npm test --",
      env = { CI = true },
      cwd = function(path)
        return vim.fn.getcwd()
      end,
    }),
  },
})

vim.keymap.set("n", "<leader>tc", function() require("neotest").run.run() end)
vim.keymap.set("n", "<leader>td", function() require("neotest").run.run({strategy = "dap"}) end)

vim.keymap.set("n", "<leader>tk", function() require("neotest").run.stop() end)
vim.keymap.set("n", "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end)

vim.keymap.set("n", "<leader>tr", function() require("neotest").output_panel.toggle()  end)
vim.keymap.set("n", "<leader>ts", function() require("neotest").summary.toggle()  end)
