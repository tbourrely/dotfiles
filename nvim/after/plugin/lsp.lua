local lsp = require("lsp-zero")

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

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'tsserver',
    'eslint',
    'gopls',
    'bashls',
    'dockerls',
    'yamlls',
    'html',
    'helm_ls',
  },
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
  },
})

require('luasnip.loaders.from_vscode').lazy_load()

local cmp = require('cmp')
local cmp_format = require('lsp-zero').cmp_format({details = true})

cmp.setup({
  formatting = cmp_format,
  sources = {
    {name = 'nvim_lsp'},
    {name = 'buffer'},
    {name = 'path'},
    {name = 'luasnip'},
  },
  mapping = cmp.mapping.preset.insert(),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})
