local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

lsp.ensure_installed({
  'tsserver',
  'eslint',
  'gopls',
  'bashls',
  'dockerls',
  'yamlls',
  'html',
  'helm_ls',
})

lsp.setup()

local cmp = require('cmp')

require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
    {name = 'buffer'},
    {name = 'path'},
    {name = 'luasnip'},
  }
})
