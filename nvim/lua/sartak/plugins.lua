require("lazy").setup({
  {
    'loctvl842/monokai-pro.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      transparent_background = true,
      filter = "classic",
      styles = {
        comment = { italic = true },
        keyword = { italic = false },
        type = { italic = false },
        storageclass = { italic = false },
        structure = { italic = false },
        parameter = { italic = false },
        annotation = { italic = false },
        tag_attribute = { italic = false },
      },
      override = function()
        return {
          String = { bg = "#1c1c1c", fg = "#ffaf5f" }
        }
      end,
    },
    config = function(_, opts)
      require("monokai-pro").setup(opts)
      vim.cmd.colorscheme("monokai-pro")
    end
  },
  {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
  {'neovim/nvim-lspconfig'},
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/nvim-cmp'},
  {'L3MON4D3/LuaSnip'},
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = { "bash", "c", "comment", "css", "csv", "devicetree", "diff", "dockerfile", "fish", "gitcommit", "git_config", "gitignore", "git_rebase", "go", "graphql", "html", "javascript", "json", "latex", "lua", "make", "markdown_inline", "perl", "pod", "proto", "query", "regex", "rust", "sql", "ssh_config", "starlark", "toml", "tsv", "tsx", "typescript", "vim", "vimdoc", "yaml" },
        auto_install = false,
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
      })
    end
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {
    'vladdoster/remember.nvim',
    tag = 'v1.4.1',
    config = function()
      require("remember").setup {
        dont_center = true,
      }
    end,
  },
  {
    'github/copilot.vim',
  },
})
