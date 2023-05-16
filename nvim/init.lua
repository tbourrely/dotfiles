vim.g.mapleader = ","

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

vim.opt.cursorline = true

require("nvim-tree").setup {
	update_focused_file = {
		enable = true
	}
}

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
  use 'christoomey/vim-tmux-navigator'
  use 'airblade/vim-gitgutter'
  use 'ervandew/supertab'
  use 'tpope/vim-sleuth'
  use 'junegunn/vim-easy-align'
  use 'voldikss/vim-floaterm'

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
    ensure_installed = { "tsserver", "gopls", "bashls", "dockerls", "yamlls" }
})
require'lspconfig'.gopls.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.bashls.setup{}
require'lspconfig'.dockerls.setup{}
require'lspconfig'.yamlls.setup{}

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


-- floaterm
vim.g.floaterm_keymap_toggle = '<leader>tt'

vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})
vim.cmd [[set mouse=a]]

local set = vim.opt -- set options
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.completeopt = menu
