_G.Config = {}

-- NOTE(pencelheimer): Load now to have 'mini.misc' available for custom loading helpers.
vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' })

local misc = require('mini.misc')
Config.now = function(f) misc.safely('now', f) end
Config.later = function(f) misc.safely('later', f) end
Config.now_if_args = vim.fn.argc(-1) > 0 and Config.now or Config.later
Config.on_event = function(ev, f) misc.safely('event:' .. ev, f) end
Config.on_filetype = function(ft, f) misc.safely('filetype:' .. ft, f) end

local gr = vim.api.nvim_create_augroup('custom-config', {})
Config.new_autocmd = function(event, pattern, callback, desc)
  local opts = { group = gr, pattern = pattern, callback = callback, desc = desc }
  vim.api.nvim_create_autocmd(event, opts)
end

Config.on_packchanged = function(plugin_name, kinds, callback, desc)
  local f = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if not (name == plugin_name and vim.tbl_contains(kinds, kind)) then return end
    if not ev.data.active then vim.cmd.packadd(plugin_name) end
    callback()
  end
  Config.new_autocmd('PackChanged', '*', f, desc)
end

Config.nmap = function(lhs, rhs, desc) vim.keymap.set('n', lhs, rhs, { desc = desc }) end
Config.vmap = function(lhs, rhs, desc) vim.keymap.set('v', lhs, rhs, { desc = desc }) end
Config.xmap = function(lhs, rhs, desc) vim.keymap.set('x', lhs, rhs, { desc = desc }) end
Config.tmap = function(lhs, rhs, desc) vim.keymap.set('t', lhs, rhs, { desc = desc }) end

Config.nmap_leader = function(suffix, rhs, desc) vim.keymap.set('n', '<Leader>' .. suffix, rhs, { desc = desc }) end
Config.vmap_leader = function(suffix, rhs, desc) vim.keymap.set('v', '<Leader>' .. suffix, rhs, { desc = desc }) end
Config.xmap_leader = function(suffix, rhs, desc) vim.keymap.set('x', '<Leader>' .. suffix, rhs, { desc = desc }) end
Config.tmap_leader = function(suffix, rhs, desc) vim.keymap.set('t', '<Leader>' .. suffix, rhs, { desc = desc }) end

-- Register filetypes
vim.filetype.add({
  extension = {
    pu = 'plantuml',
    puml = 'plantuml',
    iuml = 'plantuml',
    wsd = 'plantuml',
  },
  pattern = {
    ['.*/waybar/config'] = 'jsonc',
    ['.*/mako/config'] = 'dosini',
    ['.*/kitty/*.conf'] = 'bash',
    ['.*/hypr/.*%.conf'] = 'hyprlang',
    ['.*tmux.conf'] = 'tmux',
    ['.*allowed_signers'] = 'sshdconfig',
  },
})
