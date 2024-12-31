-- need to specify options before loading lazy so they apply to all buffers
-- https://github.com/folke/lazy.nvim/issues/1461#issuecomment-2118737477

vim.g.mapleader = " "

vim.cmd("syntax off")

vim.g.copilot_no_tab_map = true

vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

vim.opt.signcolumn = 'no'

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.shiftround = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.cache/nvim/undo"
vim.opt.undofile = true

vim.opt.scrolloff = 3

vim.g.undotree_SetFocusWhenToggle = 1
