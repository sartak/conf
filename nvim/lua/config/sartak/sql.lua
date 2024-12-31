vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead", }, {
  pattern = "*.psql,*.sqlite",
  callback = function()
    vim.bo.filetype = 'sql'
  end
})
