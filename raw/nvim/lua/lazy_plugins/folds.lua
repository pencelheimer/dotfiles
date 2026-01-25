return {
  'OXY2DEV/foldtext.nvim',
  lazy = false,
  opts = {
    styles = {
      default = {
        { kind = 'bufline', delimiter = ' ... ' },
        { kind = 'fold_size', padding_left = ' ', icon = '󰘖 ', icon_hl = '@conditional', hl = '@number' },
      },
    },
  },
}
