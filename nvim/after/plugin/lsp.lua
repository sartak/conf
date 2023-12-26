local lsp_zero = require('lsp-zero')
require("lsp-format").setup {}

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr})
  require("lsp-format").on_attach(client, bufnr)
end)

require('lspconfig').bashls.setup({})
require('lspconfig').cssls.setup({})
require('lspconfig').dockerls.setup({})
require('lspconfig').jsonls.setup({})
require('lspconfig').rust_analyzer.setup({})
require('lspconfig').tailwindcss.setup({})
require('lspconfig').tsserver.setup({})
require('lspconfig').eslint.setup({})

vim.opt.signcolumn = 'no'
