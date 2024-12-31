return {
  {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
      user_default_options = {
        mode = 'virtualtext',
        virtualtext_inline = true,
        names = false,
        css = true,
      },
      filetypes = {
        "*",
        css = { names = true },
      },
    },
  }
}
