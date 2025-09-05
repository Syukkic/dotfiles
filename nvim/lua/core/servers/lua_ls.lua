vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },

  filetypes = { 'lua' },

  -- Sets the "root directory" to the parent directory of the file in the
  -- current buffer that contains either a ".luarc.json" or a
  -- ".luarc.jsonc" file. Files that share a root directory will reuse
  -- the connection to the same LSP server.
  -- Nested lists indicate equal priority, see |vim.lsp.Config|.
  root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'bit', 'vim', 'it', 'describe', 'before_each', 'after_each' },
      },
    },
  },
})
