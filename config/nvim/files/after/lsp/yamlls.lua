return {
  settings = {
    yaml = {
      -- schemastore compat
      schemaStore = {
        enable = false,
        url = "",
      },

      schemas = require('schemastore').yaml.schemas(),
    },
  },
}
