local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('lspconfig').bashls.setup({})
require('lspconfig').cssls.setup({})
require('lspconfig').dockerls.setup({})
require('lspconfig').jsonls.setup({})
require('lspconfig').rust_analyzer.setup({})
require('lspconfig').tailwindcss.setup({})
require('lspconfig').tsserver.setup({})

require('lspconfig').eslint.setup({
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
})

vim.opt.signcolumn = 'no'
