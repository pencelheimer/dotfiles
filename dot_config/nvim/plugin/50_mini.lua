local setup_later = function(mod_name)
  Config.later(function() require(mod_name).setup() end)
end

setup_later('mini.bufremove')
setup_later('mini.cmdline')
setup_later('mini.comment')
setup_later('mini.cursorword')
setup_later('mini.indentscope')
setup_later('mini.jump')
setup_later('mini.move')
setup_later('mini.git')
setup_later('mini.pick')
setup_later('mini.splitjoin')
setup_later('mini.surround')
setup_later('mini.trailspace')
setup_later('mini.extra')
setup_later('mini.ai')

Config.later(function()
  require("mini.jump").setup()
  vim.api.nvim_set_hl(
    0,
    'MiniJump',
    { fg = '#f43841', underline = true, force = true }
  )
end)

Config.later(function()
  local miniclue = require('mini.clue')
  miniclue.setup({
    window = { config = { width = "auto" } },
    clues = {
      Config.leader_group_clues,
      miniclue.gen_clues.builtin_completion(),
      miniclue.gen_clues.g(),
      miniclue.gen_clues.marks(),
      miniclue.gen_clues.registers(),
      miniclue.gen_clues.square_brackets(),
      miniclue.gen_clues.windows({ submode_resize = true }),
      miniclue.gen_clues.z(),
    },
    triggers = {
      { mode = { 'n', 'x' }, keys = '<Leader>' }, -- Leader triggers
      { mode = 'n',          keys = '\\' },       -- mini.basics
      { mode = { 'n', 'x' }, keys = '[' },        -- mini.bracketed
      { mode = { 'n', 'x' }, keys = ']' },
      { mode = 'i',          keys = '<C-x>' },    -- Built-in completion
      { mode = { 'n', 'x' }, keys = 'g' },        -- `g` key
      { mode = { 'n', 'x' }, keys = "'" },        -- Marks
      { mode = { 'n', 'x' }, keys = '`' },
      { mode = { 'n', 'x' }, keys = '"' },        -- Registers
      { mode = { 'i', 'c' }, keys = '<C-r>' },
      { mode = 'n',          keys = '<C-w>' },    -- Window commands
      { mode = { 'n', 'x' }, keys = 's' },        -- `s` key (mini.surround, etc.)
      { mode = { 'n', 'x' }, keys = 'z' },        -- `z` key
    },
  })
end)
