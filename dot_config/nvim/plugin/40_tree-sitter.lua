Config.new_autocmd(
  "User", "TSUpdate",
  function()
    require("nvim-treesitter.parsers").kitty = {
      install_info = {
        url = "https://github.com/OXY2DEV/tree-sitter-kitty",
      },
    }
  end,
  "Additional treesitter sources"
)

Config.now(function()
  local ts_update = function() vim.cmd('TSUpdate') end
  Config.on_packchanged('nvim-treesitter', { 'update' }, ts_update, ':TSUpdate')

  vim.pack.add({
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
    'https://github.com/MeanderingProgrammer/treesitter-modules.nvim',
  })

  require("nvim-treesitter").setup()
  require("treesitter-modules").setup {
    auto_install = true,

    ensure_installed = {
      "lua", "query", "regex",
      "vim", "vimdoc",

      "c", "cpp", "zig",
      "python", "rust", "go",

      "html",
      "javascript", "css",
      "typescript", "tsx",

      "dockerfile", "json",
      "make", "toml", "yaml",

      "awk", "bash", "sql",
      "jq", "markdown",
      "markdown_inline",

      "comment"
    },

    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },

    incremental_selection = {
      enable = true,
      keymaps = {
        node_incremental = 'v',
        node_decremental = 'V',
      },
    },
  }
end)
