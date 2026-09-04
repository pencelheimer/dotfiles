local ok, schemastore = pcall(require, 'schemastore')

return {
  settings = {
    json = {
      schemas = ok and schemastore.json.schemas() or {},
      validate = { enable = true },
    },
  },
}
