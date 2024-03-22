local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager

   use({
      "folke/trouble.nvim",
      config = function()
          require("trouble").setup {
              icons = false,
          }
      end
  })

  use { "catppuccin/nvim", as = "catppuccin" }

  use 'fatih/vim-go'
  use 'tpope/vim-commentary'
  use 'tpope/vim-surround'
  use 'raimondi/delimitmate'
  use 'christoomey/vim-tmux-navigator'
  use 'airblade/vim-gitgutter'
  use 'tpope/vim-sleuth'
  use 'junegunn/vim-easy-align'
  use 'voldikss/vim-floaterm'
  use 'towolf/vim-helm'
  use 'f-person/git-blame.nvim'

  use("tpope/vim-fugitive")

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

  use({"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"})
  use 'nvim-treesitter/nvim-treesitter-context'
  use "windwp/nvim-ts-autotag"

  use {
	  'VonHeikemen/lsp-zero.nvim',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-buffer'},
		  {'hrsh7th/cmp-path'},
		  {'saadparwaiz1/cmp_luasnip'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'hrsh7th/cmp-nvim-lua'},
		  {'hrsh7th/cmp-nvim-lsp-signature-help'},

		  -- Snippets
		  {'L3MON4D3/LuaSnip'},
		  {'rafamadriz/friendly-snippets'},
	  }
  }
end)
