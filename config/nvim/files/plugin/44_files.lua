Config.now(function()
  require('mini.files').setup({
    windows = { preview = true, width_preview = 50 },
    mappings = {
      go_in_plus = "<CR>",
      go_out_plus = "-",
      go_in = '',
      go_out = '',
    }
  })

  local add_marks = function()
    MiniFiles.set_bookmark('c', vim.fn.stdpath('config'), { desc = 'Config' })
    MiniFiles.set_bookmark('w', vim.fn.getcwd, { desc = 'Working directory' })
  end
  Config.new_autocmd('User', 'MiniFilesExplorerOpen', add_marks, 'Add bookmarks')

  -- Mappings for splits ===========================================================

  local map_split = function(buf_id, lhs, direction)
    local rhs = function()
      local cur_target = MiniFiles.get_explorer_state().target_window
      local new_target = vim.api.nvim_win_call(cur_target, function()
        vim.cmd(direction .. ' split')
        return vim.api.nvim_get_current_win()
      end)

      MiniFiles.set_target_window(new_target)
      MiniFiles.go_in()
      MiniFiles.close()
    end

    local desc = 'Split ' .. direction
    vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
  end

  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesBufferCreate',
    callback = function(args)
      local buf_id = args.data.buf_id
      map_split(buf_id, '<C-h>', 'horizontal')
      map_split(buf_id, '<C-v>', 'vertical')
      map_split(buf_id, '<C-t>', 'tab')
    end,
  })

  -- Mappings to show/hide dot-files ==============================================

  local show_dotfiles = true

  local filter_show = function(_fs_entry) return true end
  local filter_hide = function(fs_entry)
    return not vim.startswith(fs_entry.name, '.')
  end

  local toggle_dotfiles = function()
    show_dotfiles = not show_dotfiles
    local new_filter = show_dotfiles and filter_show or filter_hide
    MiniFiles.refresh({ content = { filter = new_filter } })
  end

  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesBufferCreate',
    callback = function(args)
      local buf_id = args.data.buf_id
      vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = buf_id })
    end,
  })

  -- Mappings to work with fs entries ==========================================

  local yank_path = function()
    local path = (MiniFiles.get_fs_entry() or {}).path
    if path == nil then return vim.notify('Cursor is not on valid entry') end
    vim.fn.setreg(vim.v.register, path)
  end

  local ui_open = function() vim.ui.open(MiniFiles.get_fs_entry().path) end
  local pdf_open = function() io.popen("zathura --fork " .. MiniFiles.get_fs_entry().path) end
  local dragndrop = function() io.popen("dragon-drop " .. MiniFiles.get_fs_entry().path) end

  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniFilesBufferCreate',
    callback = function(args)
      local b = args.data.buf_id
      vim.keymap.set('n', 'gx', ui_open, { buffer = b, desc = 'OS open' })
      vim.keymap.set('n', 'gp', pdf_open, { buffer = b, desc = 'PDF open' })
      vim.keymap.set('n', 'gd', dragndrop, { buffer = b, desc = 'Drag-n-Drop' })
      vim.keymap.set('n', 'gy', yank_path, { buffer = b, desc = 'Yank path' })
    end,
  })
end)
