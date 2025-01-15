return {
  {
    "ibhagwan/fzf-lua",
    opts = {
      "border-fused",
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
          title = false,
          winopts = {
            number = false,
          },
        },
      },
      files = {
        winopts = {
          title = false,
        },
      },
      grep = {
        prompt = "rg> ",
        winopts = {
          title = false,
        },
      },
    },
  },
}
