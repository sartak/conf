return {
  {
    'stevearc/conform.nvim',
    opts = {
      format_on_save = {
        timeout_ms = 10000,
        lsp_format = "fallback",
      },
      formatters_by_ft = {
        eruby = { "erb_lint" },
      },
      formatters = {
        erb_lint = {
          stdin = false,
          tmpfile_format = ".conform.$RANDOM.$FILENAME",
          command = "bundle",
          args = { "exec", "erb_lint", "--autocorrect", "--fail-level", "f", "$FILENAME" },
        },
      },
    },
  }
}
