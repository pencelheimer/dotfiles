-- No need in setup call
vim.pack.add({
  'https://github.com/nishigori/increment-activator', -- More actions like true -> false -> true ...
  'https://github.com/tpope/vim-sleuth',              -- Filetype based tab width
  'https://github.com/tpope/vim-eunuch',              -- Mkdir, Chown, Move, SudoWrite, etc. commands
  'https://github.com/lifepillar/pgsql.vim',          -- PgSQL syntax highlight
  'https://github.com/aklt/plantuml-syntax',          -- PlantUML syntax highlight
  'https://github.com/b0o/schemastore.nvim',          -- Common Json and Yaml schemas
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
    outline_items = {
      show_symbol_details = false,
      auto_close = false,
      show_numbers = false,
      show_relative_numbers = false,
    },
    symbol_folding = {
      autofold_depth = 2,
    }
  }
end)

-- Smart search and substitute
Config.later(function()
  vim.pack.add({ 'https://github.com/tpope/vim-abolish' })
  vim.cmd 'cabbrev S Subvert'
  vim.api.nvim_set_keymap('n', '/', ':Abolish -search ', {})
end)


-- Typst preview for tinymist
Config.later(function()
  vim.pack.add({ 'https://github.com/chomosuke/typst-preview.nvim' })

  require("typst-preview").setup {
    follow_cursor = true,
    open_cmd = "helium-browser --profile-directory='Profile 1' --class='typst-preview' %s",
    dependencies_bin = { tinymist = "tinymist", websocat = "websocat" }
  }
end)

-- PlantUML auto compile
Config.later(function()
  vim.pack.add({ 'https://gitlab.com/itaranto/plantuml.nvim' })

  require("plantuml").setup {
    renderer = {
      type = 'image',
      options = {
        prog = 'loupe',
        dark_mode = true,
        format = 'svg'
      }
    }
  }
end)
