return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
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
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      require("lspconfig").bashls.setup {
        capabilities = capabilities,
      }
      require("lspconfig").cssls.setup {
        capabilities = capabilities,
      }
      require("lspconfig").dockerls.setup {
        capabilities = capabilities,
      }
      require("lspconfig").eslint.setup {
        capabilities = capabilities,
      }
      require("lspconfig").html.setup {
        capabilities = capabilities,
      }
      require("lspconfig").jsonls.setup {
        capabilities = capabilities,
      }
      require("lspconfig").lua_ls.setup {
        capabilities = capabilities,
      }
      require("lspconfig").ruby_lsp.setup {
        capabilities = capabilities,
        filetypes = { "ruby" }, -- eruby doesn't work great
      }
      require("lspconfig").rust_analyzer.setup {
        capabilities = capabilities,
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = {
              command = "clippy",
            },
          },
        },
      }
      require("lspconfig").sorbet.setup {
        capabilities = capabilities,
        cmd = { "srb", "tc", "--lsp", "--disable-watchman" },
      }
      require("lspconfig").tailwindcss.setup {
        capabilities = capabilities,
      }
      require("lspconfig").ts_ls.setup {
        capabilities = capabilities,
      }

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
