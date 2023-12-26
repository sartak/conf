vim.keymap.set("n", "(", "{", { noremap = true })
vim.keymap.set("v", "(", "{", { noremap = true })
vim.keymap.set("n", ")", "}", { noremap = true })
vim.keymap.set("v", ")", "}", { noremap = true })

-- TODO: integrate with LSP
vim.keymap.set("n", "{", "")
vim.keymap.set("v", "{", "")
vim.keymap.set("n", "}", "")
vim.keymap.set("v", "}", "")

vim.keymap.set("n", "v", "V", { noremap = true })
vim.keymap.set("v", "v", "V", { noremap = true })
vim.keymap.set("n", "V", "<C-V>", { noremap = true })
vim.keymap.set("v", "V", "<C-V>", { noremap = true })
vim.keymap.set("n", "<C-V>", "v", { noremap = true })
vim.keymap.set("i", "<C-V>", "v", { noremap = true })
