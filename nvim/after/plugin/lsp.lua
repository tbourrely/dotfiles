local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
  -- vim.api.nvim_create_autocmd("BufWritePre", {
  --   buffer = bufnr,
  --   command = "EslintFixAll"
  -- })

  vim.keymap.set('n', 'gx', function() 
    vim.cmd [[split]]
    vim.lsp.buf.definition()
  end , {buffer = bufnr})

  vim.keymap.set('n', 'gv', function() 
    vim.cmd [[vertical botright split]]
    vim.lsp.buf.definition()
  end , {buffer = bufnr})
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
