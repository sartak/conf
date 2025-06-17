return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = { "bash", "c", "comment", "css", "csv", "devicetree", "diff", "dockerfile", "fish", "gitcommit", "git_config", "gitignore", "git_rebase", "go", "graphql", "html", "javascript", "json", "json5", "latex", "liquid", "lua", "make", "markdown_inline", "nginx", "perl", "pod", "proto", "query", "regex", "ruby", "rust", "sql", "ssh_config", "starlark", "toml", "tsv", "tsx", "typescript", "vim", "vimdoc", "xml", "yaml" },
        auto_install = false,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = true,
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
        },
      }
    end,
  },
}
