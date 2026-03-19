-- General mappings ===========================================================
-- Paste linewise before/after current line
-- Usage: `yiw` to yank a word and `]p` to put it on the next line.
Config.nmap('[p', '<Cmd>exe "iput! " . v:register<CR>', 'Paste Above')
Config.nmap(']p', '<Cmd>exe "iput "  . v:register<CR>', 'Paste Below')

-- Clear search highlight
Config.nmap('<Esc>', '<cmd>nohlsearch<CR>')

-- Exit terminal mode in the builtin terminal
Config.tmap('<Esc><Esc>', '<C-\\><C-n>', 'Exit terminal mode')

-- Move between windows
Config.nmap('<C-h>', '<C-w><C-h>', 'Move focus left')
Config.nmap('<C-l>', '<C-w><C-l>', 'Move focus right')
Config.nmap('<C-j>', '<C-w><C-j>', 'Move focus down')
Config.nmap('<C-k>', '<C-w><C-k>', 'Move focus up')

-- Fast actions
Config.nmap('<C-c>', 'ciw', 'Change current word')
Config.nmap('<C-y>', 'yiw', 'Copy current word')
Config.nmap('<C-f>', '<Cmd>lua require("conform").format()<CR>', 'Format')
Config.xmap('<C-f>', '<Cmd>lua require("conform").format()<CR>', 'Format selection')

-- Open file explorer
Config.nmap('\\', '<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>', 'Directory')

-- Leader mappings ============================================================
Config.leader_group_clues = {
  { mode = 'n', keys = '<Leader>b', desc = '+Buffer' },
  { mode = 'n', keys = '<Leader>e', desc = '+Explore/Edit' },
  { mode = 'n', keys = '<Leader>f', desc = '+Find' },
  { mode = 'n', keys = '<Leader>g', desc = '+Git' },
  { mode = 'n', keys = '<Leader>l', desc = '+Language' },
  { mode = 'n', keys = '<Leader>m', desc = '+Map' },
  { mode = 'n', keys = '<Leader>o', desc = '+Other' },
  { mode = 'n', keys = '<Leader>s', desc = '+Session' },
  { mode = 'n', keys = '<Leader>d', desc = '+Debug' },

  { mode = 'n', keys = '<Leader>t', desc = '+Toggle' },

  { mode = 'x', keys = '<Leader>g', desc = '+Git' },
  { mode = 'x', keys = '<Leader>l', desc = '+Language' },
}

-- b is for 'Buffer'. Common usage:
-- - `<Leader>bs` - create scratch (temporary) buffer
-- - `<Leader>ba` - navigate to the alternative buffer
-- - `<Leader>bw` - wipeout (fully delete) current buffer
local new_scratch_buffer = function()
  vim.api.nvim_win_set_buf(0, vim.api.nvim_create_buf(true, true))
end

Config.nmap_leader('ba', '<Cmd>b#<CR>', 'Alternate')
Config.nmap_leader('bd', '<Cmd>lua MiniBufremove.delete()<CR>', 'Delete')
Config.nmap_leader('bD', '<Cmd>lua MiniBufremove.delete(0, true)<CR>', 'Delete!')
Config.nmap_leader('bs', new_scratch_buffer, 'Scratch')
Config.nmap_leader('bw', '<Cmd>lua MiniBufremove.wipeout()<CR>', 'Wipeout')
Config.nmap_leader('bW', '<Cmd>lua MiniBufremove.wipeout(0, true)<CR>', 'Wipeout!')

-- e is for 'Explore' and 'Edit'. Common usage:
-- - `<Leader>ed` - open explorer at current working directory
-- - `<Leader>ef` - open directory of current file (needs to be present on disk)
-- - `<Leader>ei` - edit 'init.lua'
local explore_quickfix = function()
  vim.cmd(vim.fn.getqflist({ winid = true }).winid ~= 0 and 'cclose' or 'copen')
end
local explore_locations = function()
  vim.diagnostic.setloclist { open = false }
  vim.cmd(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and 'lclose' or 'lopen')
end

Config.nmap_leader('ei', '<Cmd>edit $MYVIMRC<CR>', 'init.lua')
Config.nmap_leader('en', '<Cmd>lua MiniNotify.show_history()<CR>', 'Notifications')
Config.nmap_leader('eq', explore_quickfix, 'Quickfix list')
Config.nmap_leader('eQ', explore_locations, 'Location list')

-- f is for 'Fuzzy Find'. Common usage:
local pick_added_hunks_buf = '<Cmd>Pick git_hunks path="%" scope="staged"<CR>'
local pick_workspace_symbols_live = '<Cmd>Pick lsp scope="workspace_symbol_live"<CR>'

Config.nmap_leader('f:', '<Cmd>Pick history scope=":"<CR>', '":" history')
Config.nmap_leader('fa', '<Cmd>Pick git_hunks scope="staged"<CR>', 'Added hunks (all)')
Config.nmap_leader('fA', pick_added_hunks_buf, 'Added hunks (buf)')
Config.nmap_leader('fb', '<Cmd>Pick buffers<CR>', 'Buffers')
Config.nmap_leader('<leader>', '<Cmd>Pick buffers<CR>', 'Buffers')
Config.nmap_leader('fc', '<Cmd>Pick git_commits<CR>', 'Commits (all)')
Config.nmap_leader('fC', '<Cmd>Pick git_commits path="%"<CR>', 'Commits (buf)')
Config.nmap_leader('fd', '<Cmd>Pick diagnostic scope="all"<CR>', 'Diagnostic workspace')
Config.nmap_leader('fD', '<Cmd>Pick diagnostic scope="current"<CR>', 'Diagnostic buffer')
Config.nmap_leader('ff', '<Cmd>Pick files<CR>', 'Files')
Config.nmap_leader('fg', '<Cmd>Pick grep_live<CR>', 'Grep live')
Config.nmap_leader('fG', '<Cmd>Pick grep pattern="<cword>"<CR>', 'Grep current word')
Config.nmap_leader('fh', '<Cmd>Pick help<CR>', 'Help tags')
Config.nmap_leader('f/', '<Cmd>Pick buf_lines scope="current"<CR>', 'Lines (buf)')
Config.nmap_leader('fm', '<Cmd>Pick git_hunks<CR>', 'Modified hunks (all)')
Config.nmap_leader('fM', '<Cmd>Pick git_hunks path="%"<CR>', 'Modified hunks (buf)')
Config.nmap_leader('fr', '<Cmd>Pick resume<CR>', 'Resume')
Config.nmap_leader('fR', '<Cmd>Pick lsp scope="references"<CR>', 'References (LSP)')
Config.nmap_leader('fs', pick_workspace_symbols_live, 'Symbols workspace (live)')
Config.nmap_leader('fS', '<Cmd>Pick lsp scope="document_symbol"<CR>', 'Symbols document')
Config.nmap_leader('fv', '<Cmd>Pick visit_paths cwd=""<CR>', 'Visit paths (all)')
Config.nmap_leader('fV', '<Cmd>Pick visit_paths<CR>', 'Visit paths (cwd)')

-- g is for 'Git'. Common usage:
local git_log_cmd = [[Git log --pretty=format:\%h\ \%as\ │\ \%s --topo-order]]
local git_log_buf_cmd = git_log_cmd .. ' --follow -- %'

Config.nmap_leader('gc', '<Cmd>Git commit<CR>', 'Commit')
Config.nmap_leader('gC', '<Cmd>Git commit --amend<CR>', 'Commit amend')
Config.nmap_leader('gd', '<Cmd>Git diff<CR>', 'Diff')
Config.nmap_leader('gD', '<Cmd>Git diff -- %<CR>', 'Diff buffer')
Config.nmap_leader('gl', '<Cmd>' .. git_log_cmd .. '<CR>', 'Log')
Config.nmap_leader('gL', '<Cmd>' .. git_log_buf_cmd .. '<CR>', 'Log buffer')
Config.nmap_leader('go', '<Cmd>lua MiniDiff.toggle_overlay()<CR>', 'Toggle overlay')
Config.nmap_leader('gs', '<Cmd>lua MiniGit.show_at_cursor()<CR>', 'Show at cursor')

Config.xmap_leader('gs', '<Cmd>lua MiniGit.show_at_cursor()<CR>', 'Show at selection')

-- l is for 'Language'.
Config.nmap_leader('la', '<Cmd>lua vim.lsp.buf.code_action()<CR>', 'Actions')
Config.nmap_leader('ld', '<Cmd>lua vim.diagnostic.open_float()<CR>', 'Diagnostic popup')
Config.nmap_leader('li', '<Cmd>lua vim.lsp.buf.implementation()<CR>', 'Implementation')
Config.nmap_leader('lh', '<Cmd>lua vim.lsp.buf.hover()<CR>', 'Hover')
Config.nmap_leader('lr', '<Cmd>lua vim.lsp.buf.rename()<CR>', 'Rename')
Config.nmap_leader('lR', '<Cmd>lua vim.lsp.buf.references()<CR>', 'References')
Config.nmap_leader('ls', '<Cmd>lua vim.lsp.buf.definition()<CR>', 'Source definition')
Config.nmap_leader('lt', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', 'Type definition')

-- o is for 'Other'.
Config.nmap_leader('ot', '<Cmd>lua MiniTrailspace.trim()<CR>', 'Trim trailspace')
Config.nmap_leader('oo', '<Cmd>Outline<CR>', 'Open file outline')

-- d is for 'Debug'.
Config.nmap_leader('dc', ":DapContinue<CR>", 'Debug: Start/Continue')
Config.nmap_leader('db', ":DapToggleBreakpoint<CR>", 'Debug: Toggle Breakpoint')
Config.nmap_leader('di', ":DapStepInto<CR>", 'Debug: Step Into (F1)')
Config.nmap_leader('do', ":DapStepOver<CR>", 'Debug: Step Over (F2)')
Config.nmap_leader('dt', ":DapStepOut<CR>", 'Debug: Step Out (F3)')
Config.nmap_leader('du', ':DapViewToggle<CR>', 'Debug: Toggle UI')

-- t is for 'Toggle'
local toggle_virtual_lines = function()
  vim.diagnostic.config { virtual_lines = not vim.diagnostic.config().virtual_lines }
end

local toggle_spell_check = function()
  vim.opt.spell = not vim.opt.spell:get()
end

local toggle_inlay_hints = function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end

Config.nmap_leader('tv', toggle_virtual_lines, 'Toggle virtual diagnostic lines')
Config.nmap_leader('ts', toggle_spell_check, 'Toggle spell checking')
Config.nmap_leader('th', toggle_inlay_hints, 'Toggle inlay hints')
