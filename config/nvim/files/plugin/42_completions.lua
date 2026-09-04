Config.now_if_args(function()
  vim.pack.add({ 'https://github.com/saghen/blink.lib', 'https://github.com/saghen/blink.cmp' })

  local cmp = require('blink.cmp')

  cmp.build():pwait()
  cmp.setup({
    snippets = { preset = 'mini_snippets' },
    sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
    completion = { documentation = { auto_show = true, auto_show_delay_ms = 0 } },
    signature = { enabled = true },
    fuzzy = { implementation = 'prefer_rust' },
  })
end)
