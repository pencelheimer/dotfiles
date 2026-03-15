-- Colorscheme ================================================================
Config.now(function()
  vim.pack.add({ "https://github.com/scottmckendry/cyberdream.nvim" })
  vim.cmd("colorscheme cyberdream")
end)

-- Icons =======================================================================
Config.now(function()
  require('mini.icons').setup()
  Config.later(MiniIcons.mock_nvim_web_devicons)
  Config.later(MiniIcons.tweak_lsp_kind)
end)

-- Notifications ================================================================
Config.now(function()
  require('mini.notify').setup { lsp_progress = { enable = false } }
end)

Config.now(function()
  vim.pack.add({ "https://github.com/j-hui/fidget.nvim" })
  require('fidget').setup()
end)

-- Highlights ===================================================================
Config.later(function()
  local hipatterns = require('mini.hipatterns')
  hipatterns.setup({
    highlighters = {
      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  })
end)

-- Statusline git diffs =========================================================
Config.later(function()
  require('mini.diff').setup()
  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniDiffUpdated',
    callback = function(data)
      local summary = vim.b[data.buf].minidiff_summary or {}
      local str = ""
      if summary.add ~= nil and summary.add > 0 then
        str = str .. '%#MiniDiffSignAdd# ' .. summary.add .. "%#MiniStatuslineDevinfo#"
      end
      if summary.change ~= nil and summary.change > 0 then
        str = str .. ' %#MiniDiffSignChange# ' .. summary.change .. "%#MiniStatuslineDevinfo#"
      end
      if summary.delete ~= nil and summary.delete > 0 then
        str = str .. ' %#MiniDiffSignDelete# ' .. summary.delete .. "%#MiniStatuslineDevinfo#"
      end
      vim.b[data.buf].minidiff_summary_string = str
    end
  })
end)

-- Statusline ===================================================================
Config.now(
  function()
    require('mini.statusline').setup {
      content = {
        active =
            function()
              local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 300 })
              local git           = MiniStatusline.section_git({ trunc_width = 40 })
              local diff          = MiniStatusline.section_diff({ trunc_width = 75, icon = " :" })

              local lsp           = 'No Active LSP'
              local clients       = vim.lsp.get_clients()
              if next(clients) ~= nil then
                for _, client in ipairs(clients) do
                  local filetypes = client.config.filetypes ---@diagnostic disable-line: undefined-field
                  if filetypes and vim.fn.index(filetypes, vim.api.nvim_get_option_value('filetype', { buf = 0 })) ~= -1 then
                    lsp = ' LSP: ' .. client.name
                  end
                end
              end

              local diagnostics = MiniStatusline.section_diagnostics({
                trunc_width = 75,
                icon = "",
                signs = {
                  ERROR = '%#DiagnosticError#' .. ' ',
                  WARN = '%#DiagnosticWarn#' .. ' ',
                  INFO = '%#DiagnosticInfo#' .. '',
                  HINT = '%#DiagnosticHint#' .. ' ',
                }
              })

              local filename    = MiniStatusline.section_filename({ trunc_width = 300 })
              local fileinfo    = MiniStatusline.section_fileinfo({ trunc_width = 120 })
              local location    = MiniStatusline.section_location({ trunc_width = 300 })
              local search      = MiniStatusline.section_searchcount({ trunc_width = 75 })

              return MiniStatusline.combine_groups({
                { hl = mode_hl,                  strings = { mode } },
                { hl = 'MiniStatuslineFilename', strings = { filename } },
                { hl = 'MiniStatuslineDevinfo',  strings = { git, lsp, diagnostics } },
                '%=',
                { hl = 'MiniStatuslineDevinfo',  strings = { diff } },
                { hl = 'MiniStatuslineFilename', strings = { fileinfo } },
                { hl = mode_hl,                  strings = { search, location } },
              })
            end,
        inactive = function()
          local filename = MiniStatusline.section_filename({ trunc_width = 120 })
          return MiniStatusline.combine_groups({
            { hl = 'CursorLine', strings = { filename } },
          })
        end
      }
    }
  end

)
