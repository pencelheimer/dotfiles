-- No need in setup call
vim.pack.add({
  'https://github.com/nishigori/increment-activator', -- More actions like true -> false -> true ...
  'https://github.com/tpope/vim-sleuth',              -- Filetype based tab width
  'https://github.com/tpope/vim-eunuch',              -- Mkdir, Chown, Move, SudoWrite, etc. commands
  'https://github.com/lifepillar/pgsql.vim',          -- Special highlights for pgsql
})

-- Go throug pairs
Config.later(function()
  vim.pack.add({ 'https://github.com/abecodes/tabout.nvim' })
  require("tabout").setup {
    tabouts = {
      { open = "'", close = "'" },
      { open = '"', close = '"' },
      { open = '`', close = '`' },
      { open = '(', close = ')' },
      { open = '[', close = ']' },
      { open = '{', close = '}' },
      { open = '<', close = '>' },
    }
  }
end)

-- Set autopair
Config.later(function()
  vim.pack.add({ 'https://github.com/windwp/nvim-autopairs' })
  require("nvim-autopairs").setup()
end)

-- File outline
Config.later(function()
  vim.pack.add({ 'https://github.com/hedyhli/outline.nvim' })
  require("outline").setup {
    outline_items = { show_symbol_details = false },
  }
end)

-- Smart search and substitue
Config.later(function()
  vim.pack.add({ 'https://github.com/tpope/vim-abolish' })
  vim.cmd 'cabbrev S Subvert'
  vim.api.nvim_set_keymap('n', '/', ':Abolish -search ', {})
end)


-- Typst preview with tynimist
Config.later(function()
  vim.pack.add({ 'https://github.com/chomosuke/typst-preview.nvim' })
  require("typst-preview").setup {
    follow_cursor = true,

    dependencies_bin = {
      tinymist = "tinymist",
      websocat = "websocat"
    }
  }
end)
