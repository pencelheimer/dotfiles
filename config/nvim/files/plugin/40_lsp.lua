Config.now_if_args(function()
  vim.pack.add({ 'https://github.com/neovim/nvim-lspconfig' })

  vim.lsp.enable({
    'taplo',
    'phpactor',
    'jsonls',
    'jdtls',
    'gopls',
    'clangd',
    'tinymist',
    'basedpyright',
    'bashls',
    'lua_ls',
    'emmet_language_server',
    'hyprls',
    -- 'rust_analyzer', -- enabled by the rustaceanvim
    'nil_ls',
    'just',
    'postgres_lsp',
    'jdtls',
    'protols',
    'kitty-lsp',
    -- 'ts_ls',
    -- 'vue_ls',
    'tsgo',
    'kotlin_lsp',
    'hls'
  })
end)
