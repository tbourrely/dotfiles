vim.g.mapleader = ","

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()


local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager

  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  }

  use { "catppuccin/nvim", as = "catppuccin" }

  use {'Shougo/deoplete.nvim', run = ':UpdateRemotePlugins'}
  use 'deoplete-plugins/deoplete-lsp'

  use 'fatih/vim-go'

  use 'tpope/vim-commentary'
  use 'tpope/vim-surround'
  use 'raimondi/delimitmate'

  use 'airblade/vim-gitgutter'

  use 'tpope/vim-sleuth'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.0',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {
	  'nvim-tree/nvim-tree.lua',
	  requires = {
		  'nvim-tree/nvim-web-devicons', -- optional, for file icons
	  },
	  tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

end)

-- LSP config
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "tsserver", "gopls" }
})
require'lspconfig'.gopls.setup{}
require'lspconfig'.tsserver.setup{}

vim.opt.number = true

vim.cmd.colorscheme "catppuccin-frappe"

vim.g['deoplete#enable_at_startup'] = 1  -- enable deoplete at startup


local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})


vim.keymap.set('n', 'gD', '<cmd>lua require"telescope.builtin".lsp_definitions({jump_type="tab"})<CR>', {noremap=true, silent=true})
vim.api.nvim_set_keymap('n', '<leader>ft', ':NvimTreeToggle<CR>', {noremap = true, silent = true})
