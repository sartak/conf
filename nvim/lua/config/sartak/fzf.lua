vim.keymap.set({ "n", "v", "i" }, "<C-t>", function() require("fzf-lua").files() end, { silent = true })
