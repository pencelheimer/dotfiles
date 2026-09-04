return {
  on_attach = function(client, buf_id)
    client.server_capabilities.completionProvider.triggerCharacters =
      { '.', ':', '#', '(' }
  end,
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT', path = vim.split(package.path, ';') },
      workspace = {
        ignoreSubmodules = true,
        library = { vim.env.VIMRUNTIME },
      },
    },
  },
}
