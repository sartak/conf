local colors = {
  normal = "#e6db74",
  command = "#e6db74",
  insert = "#a6e22e",
  visual = "#ae81ff",
  replace = "#f92672",
  mode = "#1d1e19",
  midground = "#222222",
  farground = "#2f3436",
  gap_bg = "none",
  gap_fg = "#a1c281",
}

local function location()
  local mode = vim.fn.mode()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  col = col + 1

  if mode == "v" or mode == "V" or mode == "" then
    local _, vline, vcol = unpack(vim.fn.getpos("v"))
    if line > vline then
      line, vline = vline, line
    end

    if col > vcol then
      col, vcol = vcol, col
    end

    return string.format("%d-%d(%d):%d-%d(%d)", col, vcol, vcol - col + 1, line, vline, vline - line + 1)
  else
    return string.format("%d:%d/%d", col, line, vim.fn.line("$"))
  end
end

return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      options = {
        theme = {
          normal = {
            a = { bg = colors.normal, fg = colors.mode, gui = "bold" },
            b = { bg = colors.farground, fg = colors.normal },
            c = { bg = colors.gap_bg, fg = colors.gap_fg },
            z = { bg = colors.midground, fg = colors.normal },
          },
          command = {
            a = { bg = colors.command, fg = colors.mode },
            b = { bg = colors.farground, fg = colors.command },
            z = { bg = colors.midground, fg = colors.normal },
          },
          insert = {
            a = { bg = colors.insert, fg = colors.mode },
            b = { bg = colors.farground, fg = colors.insert },
            z = { bg = colors.midground, fg = colors.insert },
          },
          visual = {
            a = { bg = colors.visual, fg = colors.mode },
            b = { bg = colors.farground, fg = colors.visual },
            z = { bg = colors.midground, fg = colors.visual },
          },
          replace = {
            a = { bg = colors.replace, fg = colors.mode },
            b = { bg = colors.farground, fg = colors.replace },
            z = { bg = colors.midground, fg = colors.replace },
          },
        },
      },
      sections = {
        lualine_a = { { "mode", fmt = function(str) return str:sub(1, 1) end } },
        lualine_b = { { "branch", icons_enabled = false } },
        lualine_c = { { "filename", file_status = false, path = 4 } },
        lualine_x = {},
        lualine_y = { location },
        lualine_z = { "diagnostics" }
      },
    },
  },
}
