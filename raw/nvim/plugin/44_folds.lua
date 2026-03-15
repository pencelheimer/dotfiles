Config.later(function()
  vim.pack.add({ 'https://github.com/OXY2DEV/foldtext.nvim' })
  require("foldtext").setup {
    styles = {
      default = {
        { kind = 'bufline', delimiter = ' ... ' },
        { kind = 'fold_size', padding_left = ' ', icon = '󰘖 ', icon_hl = '@conditional', hl = '@number' },
      },
      ts_expr = {
        { kind = 'bufline', delimiter = ' ... ' },
        { kind = 'fold_size', padding_left = ' ', icon = '󰘖 ', icon_hl = '@conditional', hl = '@number' },
      }
    },
  }
end)
