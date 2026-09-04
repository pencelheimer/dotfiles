Config.on_event("BufRead~Cargo.toml", function()
  vim.pack.add({ 'https://github.com/saecki/crates.nvim' })
  require("crates").setup {
    lsp = {
      enabled = true,
      actions = true,
      completion = true,
      hover = true
    }
  }
end)

Config.now(function()
  vim.g.rustaceanvim = function()
    local codelldb_path = os.getenv("CODELLDB_PATH")
    local liblldb_path = os.getenv("LIBLLDB_PATH")

    local cfg = require('rustaceanvim.config')
    return {
      dap = {
        adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
      },
    }
  end

  vim.pack.add({ 'https://github.com/mrcjkb/rustaceanvim' })
end)
