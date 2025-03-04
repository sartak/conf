vim.keymap.set("n", "(", "{", { noremap = true })
vim.keymap.set("v", "(", "{", { noremap = true })
vim.keymap.set("n", ")", "}", { noremap = true })
vim.keymap.set("v", ")", "}", { noremap = true })

vim.keymap.set("n", "{", function() vim.diagnostic.goto_prev({ _highest = true }) end)
vim.keymap.set("v", "{", function() vim.diagnostic.goto_prev({ _highest = true }) end)
vim.keymap.set("n", "}", function() vim.diagnostic.goto_next({ _highest = true }) end)
vim.keymap.set("v", "}", function() vim.diagnostic.goto_next({ _highest = true }) end)

vim.keymap.set("n", "v", "V", { noremap = true })
vim.keymap.set("v", "v", "V", { noremap = true })
vim.keymap.set("n", "V", "<C-V>", { noremap = true })
vim.keymap.set("v", "V", "<C-V>", { noremap = true })
vim.keymap.set("n", "<C-V>", "v", { noremap = true })
vim.keymap.set("i", "<C-V>", "v", { noremap = true })

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
