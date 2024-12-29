local function quickfix()
  vim.lsp.buf.code_action({
    filter = function(a) return a.isPreferred end,
    apply = true
  })
end

vim.keymap.set('n', 'Q', quickfix, { noremap = true, silent = true })
