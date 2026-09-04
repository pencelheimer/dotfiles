Config.later(function()
  vim.pack.add({
    'https://github.com/mfussenegger/nvim-dap',
    'https://github.com/igorlfs/nvim-dap-view',
    'https://github.com/leoluz/nvim-dap-go',
    'https://github.com/julianolf/nvim-dap-lldb',
  })

  local signs = {
    { 'DapBreakpoint', '', 'DiagnosticSignError' },
    { 'DapBreakpointCondition', '', 'DiagnosticSignError' },
    { 'DapBreakpointRejected', '', 'DiagnosticSignWarning' },
    { 'DapStopped', '', 'DiagnosticSignOk'
    },

    { 'DapLogPoint', '', 'DiagnosticSignInfo' },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign[1], { text = sign[2], texthl = sign[3], linehl = 'DapBreakpoint', numhl = 'DapBrealpoint' })
  end

  require('dap-go').setup()
  require("dap-lldb").setup({ codelldb_path = os.getenv("CODELLDB_PATH") })
end)
