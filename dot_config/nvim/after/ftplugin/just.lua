-- Disable Just LSP highlighting so Tree-sitter injections work
local lsp_blockers = {
  "@lsp.type.string.just",
  "@lsp.type.comment.just",
}

for _, group in ipairs(lsp_blockers) do
  vim.api.nvim_set_hl(0, group, {})
end
