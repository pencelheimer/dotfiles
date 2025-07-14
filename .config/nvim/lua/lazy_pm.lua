local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    dir = '~/stuff/projects/imp.nvim',
    name = 'imp',
    opts = {},
  },

  {
    'scottmckendry/cyberdream.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
    init = function()
      vim.cmd 'colorscheme cyberdream'
    end,
  },

  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        { path = 'LazyVim', words = { 'LazyVim' } },
      },
    },
  },
  {
    'michaelrommel/nvim-silicon',
    cmd = 'Silicon',
    opts = {
      font = 'IosevkaTerm Nerd Font=34',
      theme = 'Dracula',
      background = '#999999',
      to_clipboard = true,
      window_title = function()
        return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ':t')
      end,
    },
  },
  {
    'Aietes/esp32.nvim',
    opts = {
      build_dir = 'build',
    },
  },

  {
    'https://github.com/aklt/plantuml-syntax',
    ft = { 'pu', 'plantuml', 'iuml', 'puml', 'wsd' },
    cmd = 'PlantUML',
    dependencies = {
      {
        'https://gitlab.com/itaranto/plantuml.nvim',
        opts = { renderer = { type = 'image', options = { prog = 'loupe', dark_mode = false, format = 'png' } } },
      },
    },
  },
  {
    'swaits/zellij-nav.nvim',
    lazy = true,
    event = 'VeryLazy',
    keys = {
      { '<c-h>', '<cmd>ZellijNavigateLeftTab<cr>', { silent = true, desc = 'navigate left or tab' } },
      { '<c-j>', '<cmd>ZellijNavigateDown<cr>', { silent = true, desc = 'navigate down' } },
      { '<c-k>', '<cmd>ZellijNavigateUp<cr>', { silent = true, desc = 'navigate up' } },
      { '<c-l>', '<cmd>ZellijNavigateRightTab<cr>', { silent = true, desc = 'navigate right or tab' } },
    },
    opts = {},
  },
  -- {
  --   'christoomey/vim-tmux-navigator',
  --   cmd = {
  --     'TmuxNavigateLeft',
  --     'TmuxNavigateDown',
  --     'TmuxNavigateUp',
  --     'TmuxNavigateRight',
  --     'TmuxNavigatePrevious',
  --     'TmuxNavigatorProcessList',
  --   },
  --   keys = {
  --     { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
  --     { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
  --     { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
  --     { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
  --     { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
  --   },
  -- },
  {
    'saecki/crates.nvim',
    tag = 'stable',
    event = { 'BufRead Cargo.toml' },
    opts = {
      popup = { border = 'single' },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },
  -- {
  --   'mrcjkb/rustaceanvim',
  --   version = '^6', -- Recommended
  --   lazy = false, -- This plugin is already lazy
  -- },

  { 'Olical/conjure', ft = { 'clj' } },
  { 'TreyBastian/nvim-jack-in', config = true },

  { 'sphamba/smear-cursor.nvim', event = 'VimEnter' },
  { 'rhysd/clever-f.vim', keys = { 'f', 'F', 't', 'T' } },
  { 'windwp/nvim-autopairs', event = 'InsertEnter', opts = {} },
  { 'nishigori/increment-activator', keys = { { '<C-a>', noremap = true }, { '<C-x>', noremap = true } } }, -- More actions like true -> false -> true ...
  {
    'tpope/vim-eunuch',
    cmd = { 'Remove', 'Delete', 'Move', 'Chmod', 'Mkdir', 'Cfind', 'Clocate', 'Lfind', 'Wall', 'SudoWrite', 'SudoEdit' },
  },
  { 'tpope/vim-sleuth', event = 'BufReadPre' }, -- Filetype based tab width
  {
    'tpope/vim-abolish',
    event = 'VeryLazy',
    config = function()
      vim.cmd 'cabbrev S Subvert'
      vim.api.nvim_set_keymap('n', '/', ':Abolish -search ', {})
    end,
  }, -- Smart substitute
  { import = 'lazy_plugins' },
}, {
  rtp = { disabled_plugins = { 'netrwPlugin' } },
  ui = { border = 'single' },
})
