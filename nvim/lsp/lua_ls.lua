local root = require('mason-registry').get_package('lua-language-server'):get_install_path()
local bin = root .. '/bin/lua-language-server'

return {
  cmd = { bin },
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim', 'luasnip' },
      },
      runtime = {
        version = 'LuaJIT',
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
      },
      telemetry = {
        enable = false,
      },
      hint = {
        enable = true,
        setType = false,
        paramType = true,
        paramName = 'Disable',
        semicolon = 'Disable',
        arrayIndex = 'Disable',
      },
    },
  },
}
