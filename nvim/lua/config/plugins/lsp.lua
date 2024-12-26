return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      require("lspconfig").bashls.setup {}
      require("lspconfig").cssls.setup {}
      require("lspconfig").dockerls.setup {}
      require("lspconfig").eslint.setup {}
      require("lspconfig").jsonls.setup {}
      require("lspconfig").lua_ls.setup {}
      require("lspconfig").ruby_lsp.setup {
        filetypes = { "ruby" }, -- eruby doesn't work great
      }
      require("lspconfig").rust_analyzer.setup {}
      require("lspconfig").tailwindcss.setup {}
      require("lspconfig").ts_ls.setup {}

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          if client.supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end
            })
          end
        end
      })
    end,
  },
}
