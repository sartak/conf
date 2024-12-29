if table.concat(vim.api.nvim_buf_get_lines(0, 0, 1, false), "\n") == "" then
  vim.cmd.startinsert()
end
