Config.new_autocmd(
  'TextYankPost', "*",
  function() vim.highlight.on_yank() end,
  'Highlight when yanking (copying) text'
)

Config.new_autocmd(
  'BufWritePre', "*",
  function() vim.o.bomb = (vim.o.fileencoding == "utf-16" or vim.o.fileencoding == "utf-16le") end,
  'Write BOM when needed'
)

Config.new_autocmd(
  'DiagnosticChanged', "*",
  function() vim.diagnostic.setloclist({ open = false }) end,
  "Auto refresh diagnostics list"
)
