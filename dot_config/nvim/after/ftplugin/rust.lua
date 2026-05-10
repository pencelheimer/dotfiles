local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set(
  "n", "<leader>ld",
  function() vim.cmd.RustLsp({ 'renderDiagnostic', 'current' }) end,
  { silent = true, buffer = bufnr }
)

vim.keymap.set(
  { "n", "v" }, "gra",
  function() vim.cmd.RustLsp('codeAction') end,
  { silent = true, buffer = bufnr }
)

vim.keymap.set(
  "n", "K",
  function() vim.cmd.RustLsp({ 'hover', 'actions' }) end,
  { silent = true, buffer = bufnr }
)

-- Disable rust-analyzer's string highlighting so Tree-sitter injections work
local lsp_blockers = {
  "@lsp.type.string.rust",
  "@lsp.typemod.string.macro.rust",
}

for _, group in ipairs(lsp_blockers) do
  vim.api.nvim_set_hl(0, group, {})
end
