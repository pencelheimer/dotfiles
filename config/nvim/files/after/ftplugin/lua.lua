-- Disable lua_ls's comment highlighting so Tree-sitter injections work
local lsp_blockers = {
  "@lsp.type.comment.lua",
}

for _, group in ipairs(lsp_blockers) do
  vim.api.nvim_set_hl(0, group, {})
end
