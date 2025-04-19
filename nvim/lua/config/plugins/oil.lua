return {
  {
    'stevearc/oil.nvim',
    opts = {
      columns = {
        "icon",
      },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    keys = {
      { "-", function() require("oil").open_float() end },
    },
  },
}
