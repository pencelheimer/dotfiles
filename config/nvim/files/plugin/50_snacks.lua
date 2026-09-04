Config.later(function()
  -- Detect and force terminal environment for snacks.nvim since it's loaded late
  -- and might miss the startup 'TermResponse' event.
  if os.getenv("TERM") == "xterm-kitty" or os.getenv("KITTY_PID") then
    vim.env.SNACKS_KITTY = "true"
  elseif os.getenv("TERM") == "xterm-ghostty" or os.getenv("GHOSTTY_PID") then
    vim.env.SNACKS_GHOSTTY = "true"
  elseif os.getenv("WEZTERM_PANE") then
    vim.env.SNACKS_WEZTERM = "true"
  end

  vim.pack.add({ 'https://github.com/folke/snacks.nvim' })

  require("snacks").setup {
    image = {
      enabled = true,
      doc = { inline = false, float = true },
    },
    styles = {
      snacks_image = {
        relative = 'editor',
        border = 'single',
        row = 0,
        col = -1,
      },
    },
  }

  -- Override snacks.image.doc.at_cursor to support general file path preview
  local has_snacks, snacks = pcall(require, "snacks")
  if has_snacks then
    local ok, doc = pcall(require, "snacks.image.doc")
    if ok then
      local original_at_cursor = doc.at_cursor

      -- Helper to check if a filename has an image extension
      local function is_image_file(path)
        if not path then return false end
        local ext = path:match("%.([^%.%/]+)$")
        if not ext then return false end
        local img_exts = {
          png = true, jpg = true, jpeg = true, gif = true, bmp = true,
          webp = true, tiff = true, heic = true, avif = true, svg = true,
        }
        return img_exts[ext:lower()] == true
      end

      -- Resolve the path relative to buffer or cwd
      local function resolve_image_path(path)
        if not path or path == "" then return nil end
        if path:find("^%w+://") then
          return path
        end
        path = vim.fn.expand(path)
        if path:find("^/") or path:find("^%w+:") then
          return vim.fn.filereadable(path) == 1 and path or nil
        end
        local buf_name = vim.api.nvim_buf_get_name(0)
        if buf_name ~= "" then
          local buf_dir = vim.fs.dirname(buf_name)
          local resolved = buf_dir .. "/" .. path
          if vim.fn.filereadable(resolved) == 1 then
            return resolved
          end
        end
        local resolved = vim.fn.getcwd() .. "/" .. path
        if vim.fn.filereadable(resolved) == 1 then
          return resolved
        end
        return nil
      end

      -- Helper to extract image path under the cursor
      local function get_image_path_at_cursor()
        local cfile = vim.fn.expand("<cfile>")
        if is_image_file(cfile) then
          return cfile
        end

        local line = vim.api.nvim_get_current_line()
        local col = vim.api.nvim_win_get_cursor(0)[2] + 1

        local patterns = { '["\'](.-)["\']', "%((.-)%)", "(%S+)" }
        for _, pattern in ipairs(patterns) do
          local start_idx = 1
          while true do
            local s, e, match = line:find(pattern, start_idx)
            if not s then break end
            if col >= s and col <= e then
              if is_image_file(match) then
                return match
              end
            end
            start_idx = e + 1
          end
        end
        return nil
      end

      doc.at_cursor = function(cb)
        local path = get_image_path_at_cursor()
        local resolved = resolve_image_path(path)
        if resolved then
          return cb(resolved, { vim.api.nvim_win_get_cursor(0)[1], 0 })
        end
        original_at_cursor(cb)
      end
    end
  end

  -- Map 'K' to show image preview if on an image path, otherwise fall back to LSP hover
  vim.keymap.set("n", "K", function()
    local has_s, s = pcall(require, "snacks")
    if has_s and s.image and s.image.supports_terminal() then
      s.image.doc.at_cursor(function(src)
        if src then
          s.image.hover()
        else
          vim.lsp.buf.hover()
        end
      end)
    else
      vim.lsp.buf.hover()
    end
  end, { desc = "Hover (Image/LSP)" })
end)
