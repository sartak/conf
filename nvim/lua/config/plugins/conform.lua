return {
  {
    'stevearc/conform.nvim',
    opts = {
      format_on_save = {
        lsp_format = "fallback",
      },
      formatters_by_ft = {
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
      },
    },
  }
}
