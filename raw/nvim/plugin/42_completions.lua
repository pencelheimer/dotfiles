Config.now_if_args(function()
  local blink_build = function(e)
    vim.notify('Building blink.cmp', vim.log.levels.INFO)
    vim.cmd.packadd({ args = { e.data.spec.name }, bang = false })
    require("blink.cmp.fuzzy.build").build()
  end
  Config.on_packchanged('blink.cmp', { 'install', 'update' }, blink_build, 'Build fyzzy matcher for the blink.cmp')

  vim.pack.add({ "https://github.com/saghen/blink.cmp" })

  require('blink.cmp').setup({
    snippets = { preset = 'mini_snippets' },
    sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
    completion = { documentation = { auto_show = true, auto_show_delay_ms = 0 } },
    signature = { enabled = true },
    fuzzy = { implementation = 'prefer_rust' },
  })
end)
