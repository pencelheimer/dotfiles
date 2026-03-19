local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set(
  "n", "<leader>ld",
  function() vim.cmd.RustLsp({ 'renderDiagnostic', 'current' }) end,
  { silent = true, buffer = bufnr }
)

vim.keymap.set(
  "n", "<leader>la",
  function() vim.cmd.RustLsp('codeAction') end,
  { silent = true, buffer = bufnr }
)

vim.keymap.set(
  "n", "K",
  function() vim.cmd.RustLsp({ 'hover', 'actions' }) end,
  { silent = true, buffer = bufnr }
)
