vim.api.nvim_create_autocmd('FocusLost', {
  group = vim.api.nvim_create_augroup('FocusLostAutosave', { clear = true }),
  callback = function()
    vim.cmd("silent! wall")
  end,
})
