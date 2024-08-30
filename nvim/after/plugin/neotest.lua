require("neotest").setup({
  adapters = {
    require("neotest-golang")({
      warn_test_not_executed = false
    }),
    require("neotest-vitest") {
      filter_dir = function(name, rel_path, root)
        return name ~= "node_modules"
      end,
    },
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
vim.keymap.set("n", "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end)
vim.keymap.set("n", "<leader>tF", function() require("neotest").run.run(vim.fn.expand("%:p:h")) end)
vim.keymap.set("n", "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end)
vim.keymap.set("n", "<leader>td", function() require("neotest").run.run({strategy = "dap"}) end)

vim.keymap.set("n", "<leader>tk", function() require("neotest").run.stop() end)

vim.keymap.set("n", "<leader>tr", function() require("neotest").output_panel.toggle()  end)
vim.keymap.set("n", "<leader>ts", function() require("neotest").summary.toggle()  end)
