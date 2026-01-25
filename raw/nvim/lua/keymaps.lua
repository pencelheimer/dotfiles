-- Diagnostic keymaps
vim.keymap.set(
  'n',
  '<leader>e',
  function()
    vim.diagnostic.open_float({ border = "single" })
  end,
  { desc = 'Show diagnostic [E]rror messages' }
)

vim.keymap.set('n', '<Leader>q', function()
  vim.diagnostic.setloclist { open = false }

  local winid = vim.fn.getloclist(0, { winid = 0 }).winid

  if winid == 0 then
    vim.cmd.lopen()
  else
    vim.cmd.lclose()
  end
end, { desc = 'Toggle diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Move between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Pipe the selection to the given shell command and insert result after selection
vim.api.nvim_create_user_command('Run', function(opts)
  local cmd = string.format("%d,%dt%d | '[,']!%s", opts.line1, opts.line2, opts.line2, opts.args)
  vim.cmd(cmd)
  vim.cmd("normal! '[V']")
end, { range = true, nargs = 1 })

-- Duplicate a line and comment out the first line
vim.keymap.set('n', 'yc', function()
  vim.api.nvim_feedkeys('yygccp', 'm', false)
end)

-- Operations on current word
vim.keymap.set('n', '<C-c>', 'ciw')
vim.keymap.set('n', '<C-y>', 'yiw')

-- Jump to the marked file
vim.keymap.set(
  'n',
  '<leader>m',
  [[:execute 'buffer' getpos("'" .. nr2char(getchar()))[0]<CR>]],
  { noremap = true, silent = true, desc = "Jump to the marked buffer" }
)

vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.keymap.set(
      "n",
      "dd",
      function()
        local qf_list = vim.fn.getqflist()
        local cur_line = vim.fn.line('.')
        if #qf_list > 0 then
          table.remove(qf_list, cur_line)
          vim.fn.setqflist(qf_list, 'r')
          vim.cmd('copen')

          local new_line = cur_line > #qf_list and #qf_list or cur_line

          if new_line > 0 then
            vim.api.nvim_win_set_cursor(0, { new_line, 0 })
          end
        end
      end,
      { buffer = true, desc = "Remove item from Quickfix list", silent = true, nowait = true }
    )
  end,
})

local toggles = {
  {
    keymap = '<leader>tv',
    callback = function()
      vim.diagnostic.config { virtual_lines = not vim.diagnostic.config().virtual_lines }
    end,
    opts = { desc = 'Toggle virtual diagnostic lines' },
  },

  {
    keymap = '<leader>tl',
    callback = function()
      if next(vim.opt.colorcolumn:get()) == nil then
        vim.opt.colorcolumn = { '81', '121' }
      else
        vim.opt.colorcolumn = ''
      end
    end,
    opts = { desc = 'Toggle limit lines' },
  },

  {
    keymap = '<leader>ts',
    callback = function()
      vim.opt.spell = not vim.opt.spell:get()
    end,
    opts = { desc = 'Toggle spell checking' },
  },

  {
    keymap = '<leader>th',
    callback = function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end,
    opts = { desc = 'Toggle inlay hints' },
  },

  {
    keymap = '<leader>tw',
    callback = function()
      vim.opt.wrap = not vim.opt.wrap:get()
    end,
    opts = { desc = 'Toggle text wrap' },
  },
}

for _, toggle in ipairs(toggles) do
  vim.keymap.set('n', toggle.keymap, toggle.callback, toggle.opts)
end
