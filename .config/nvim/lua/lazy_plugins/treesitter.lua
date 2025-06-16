return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
  build = ':TSUpdate',
  lazy = true,
  event = 'BufRead',
  opts = {
    ensure_installed = { 'bash', 'diff', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc' },
    auto_install = true,
    prefer_git = true,
    highlight = { enable = true, additional_vim_regex_highlighting = { 'ruby' } },
    indent = { enable = true, disable = { 'ruby' } },
    incremental_selection = {
      enable = true,
      keymaps = {
        node_incremental = 'v',
        node_decremental = 'V',
      },
    },

    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ['af'] = { query = '@function.outer', desc = 'outer function' },
          ['if'] = { query = '@function.inner', desc = 'inner function' },
          ['ac'] = { query = '@class.outer', desc = 'outer class' },
          ['ic'] = { query = '@class.inner', desc = 'inner class' },
          ['ab'] = { query = '@block.outer', desc = 'outer block' },
          ['ib'] = { query = '@block.inner', desc = 'inner block' },
          ['al'] = { query = '@loop.outer', desc = 'outer loop' },
          ['il'] = { query = '@loop.inner', desc = 'inner loop' },
          ['a/'] = { query = '@comment.outer', desc = 'outer comment' },
          ['i/'] = { query = '@comment.outer', desc = 'outer comment' },
          ['aa'] = { query = '@parameter.outer', desc = 'outer parameter' },
          ['ia'] = { query = '@parameter.inner', desc = 'inner parameter' },
        },
      },
    },
  },
}
