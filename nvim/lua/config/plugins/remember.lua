return {
  {
    'vladdoster/remember.nvim',
    config = function()
      require("remember").setup {
        dont_center = true,
      }
    end,
  },
}
