Config.now(function()
  vim.pack.add({
    'https://github.com/aklt/plantuml-syntax',
    'https://gitlab.com/itaranto/plantuml.nvim',
  })

  require("plantuml").setup {
    renderer = {
      type = 'image',
      options = {
        prog = 'image-roll',
        dark_mode = false,
        format = 'svg'
      }
    }
  }
end)
