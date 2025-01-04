return {
  {
    "ibhagwan/fzf-lua",
    opts = {
      defaults = {
        header = false,
      },
      winopts = {
        height = 0.9,
        width = 0.9,
        row = 0.2,
        col = 0.5,
        preview = {
          vertical = 'down:75%',
          layout = 'vertical',
          title = false,
          -- https://github.com/ibhagwan/fzf-lua/issues/1668
          border = 'border-top',
          winopts = {
            number = false,
          },
        },
      },
      grep = {
        prompt = "rg> ",
      },
    },
  },
}
