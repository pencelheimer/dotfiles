return {
  'stevearc/conform.nvim',
  cmd = { "ConformInfo" },
  keys = {
    { "<c-f>", function() require("conform").format({ async = true }) end, mode = "", desc = "Format buffer" },
  },

  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    notify_on_error = true,
    -- format_on_save = { timeout_ms = 500 },
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'isort', 'black' },
      rust = { 'rustfmt' },
      cpp = { 'clang-format' },
      c = { 'clang-format' },
      nix = { "alejandra" },
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
