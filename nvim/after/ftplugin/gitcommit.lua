local is_new = vim.fn.search("^# Initial commit$", "n") ~= 0
local is_amend = table.concat(vim.api.nvim_buf_get_lines(0, 0, 1, false), "\n") ~= ""

local origin = vim.fn.search("^# Please enter the commit message", "n")

local indent
if is_amend then
  indent = "   "
  origin = origin - 1
else
  indent = ""
end

local replacement
local offset
if is_new then
  local line = vim.fn.search("^# Initial commit$", "n")

  offset = 1
  if is_amend then
    offset = 3
  else
    line = line - 1
  end

  -- Remove initial commit line since we're adding our own
  vim.api.nvim_buf_set_lines(0, line - 1, line + 1, false, {})

  replacement = { "# Parent: " .. indent .. "(initial commit)" }
else
  local command
  if is_amend then
    command = [[git log -1 HEAD~1 --format='format:%h %s']]
    offset = 3
  else
    command = [[git log -1 --format='format:%h %s']]
    offset = 1
  end
  local handle = io.popen(command)
  local parent = handle:read("*a")
  handle:close()
  replacement = { "# Parent: " .. indent .. parent }
end

vim.api.nvim_buf_set_lines(0, origin - 1, origin + offset, false, replacement)

if not is_amend then
  vim.cmd.startinsert()
end
