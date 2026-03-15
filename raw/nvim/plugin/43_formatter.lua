Config.later(function()
  vim.pack.add({ 'https://github.com/stevearc/conform.nvim' })

  require('conform').setup({
    notify_on_error = true,
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
  })
end)
