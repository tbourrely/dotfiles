-- LSP config
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "tsserver", "gopls", "bashls", "dockerls", "yamlls", "eslint" }
})
require'lspconfig'.gopls.setup{}
require('lspconfig').tsserver.setup({
    init_options = {
        preferences = {
            disableSuggestions = true,
        },
    },
})
require'lspconfig'.bashls.setup{}
require'lspconfig'.dockerls.setup{}
require'lspconfig'.yamlls.setup{}
require'lspconfig'.eslint.setup{}

-- Set up nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  window = {},
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.abort(),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'vsnip' },
    {
      name = 'buffer',
      option = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end,
      }
    },
  }, {
    { name = 'buffer' },
  })
})
