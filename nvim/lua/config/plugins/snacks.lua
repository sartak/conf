return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      styles = {
        dashboard = {
          wo = {
            fillchars = 'eob: ',
          },
        },
      },
      dashboard = {
        -- prefer letter hotkeys instead of numerals
        autokeys = "abcdefghjklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        preset = {
          keys = {
            { desc = "Insert", key = "i", action = ":ene | startinsert", hidden = true },
          },
        },
        formats = {
          file = function(item, ctx)
            -- NOTE: this function is the same as upstream but adding `:.` to
            -- shorten with relative paths
            local fname = vim.fn.fnamemodify(item.file, ":~:.")
            fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
            if #fname > ctx.width then
              local dir = vim.fn.fnamemodify(fname, ":h")
              local file = vim.fn.fnamemodify(fname, ":t")
              if dir and file then
                file = file:sub(-(ctx.width - #dir - 2))
                fname = dir .. "/…" .. file
              end
            end
            local dir, file = fname:match("^(.*)/(.+)$")
            return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } } or { { fname, hl = "file" } }
          end,
        },
        sections = {
          { section = "keys" },
          { section = "recent_files", cwd = true, limit = 16 },
        },
      },
    },
  }
}
