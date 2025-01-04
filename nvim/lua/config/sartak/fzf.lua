vim.keymap.set({ "n", "v", "i" }, "<C-t>", function() require("fzf-lua").files() end, { silent = true })
vim.keymap.set({ "n", "v", "i" }, "<C-g>", function() require("fzf-lua").live_grep_native() end, { silent = true })
