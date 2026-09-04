Config.now(function()
  vim.pack.add({
    { src = 'https://github.com/romus204/tree-sitter-manager.nvim' },
    { src = 'https://github.com/maxischmaxi/inc-select.nvim' },
  })

  require("tree-sitter-manager").setup({
    auto_install = true,
    -- these ship built into Neovim core, no need to fetch them
    noauto_install = { "c", "lua", "markdown", "markdown_inline", "query", "vim", "vimdoc" },

    ensure_installed = {
      "lua", "query", "regex", "vim", "vimdoc",
      "c", "cpp", "zig", "python", "rust", "go", "haskell",
      "html", "javascript", "css", "typescript", "tsx",
      "dockerfile", "json", "make", "toml", "yaml",
      "awk", "bash", "sql", "jq", "markdown",
      "markdown_inline", "comment", "kitty",
      "kanshi"
    },

    languages = {
      kitty = {
        install_info = {
          url = "https://github.com/OXY2DEV/tree-sitter-kitty",
        },
      },
      kanshi = {
        install_info = {
          url = "https://github.com/pencelheimer/tree-sitter-kanshi",
        },
      },
    },
  })

  require("inc-select").setup({
    keymaps = {
      node_incremental = 'v',
      node_decremental = 'V',
    },
  })
end)
