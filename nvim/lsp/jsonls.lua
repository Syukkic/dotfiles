vim.lsp.config('jsonls', {

  cmd = { 'vscode-json-language-server', '--stdio' },
  filetypes = { 'json' },
  init_options = {
    provideFormatter = true,
  },
})
