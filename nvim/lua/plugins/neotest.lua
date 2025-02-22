return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      { "fredrikaverpil/neotest-golang", version = "*" }, -- Installation
    },
    keys = {
      { "<leader>tr", function()
	require("neotest").run.run()
      end },
      { "<leader>tf", function()
	require("neotest").run.run(vim.fn.expand("%"))
      end },
    },
    config = function()
      local neotest_golang_opts = {}  -- Specify custom configuration
      require("neotest").setup({
	adapters = {
	  require("neotest-golang")(neotest_golang_opts), -- Registration
	},
      })
    end,
  },
}
