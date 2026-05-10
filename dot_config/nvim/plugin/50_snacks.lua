Config.later(function()
  vim.pack.add({ 'https://github.com/folke/snacks.nvim' })

  require("snacks").setup {
    statuscolumn = {
      enabled = true,
      left = { 'mark', 'sign' },
      right = { 'fold' },
      folds = { open = true, git_hl = true },
      refresh = 50,
    },
    image = {
      enabled = true,
      doc = { inline = false, float = true },
    },
    styles = {
      snacks_image = {
        relative = 'editor',
        border = 'single',
        row = 0,
        col = -1,
      },
    },
  }
end)
