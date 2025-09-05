vim.lsp.config('pyright', {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  settings = {
    python = {
      analysis = {
        typeCheckingMode = 'basic', -- "off", "basic", or "strict"
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        stubPath = 'typings',
        diagnosticSeverityOverrides = {
          reportAttributeAccessIssue = 'none', -- or 'warning'
        },
        reportMissingImports = true,
        reportUnusedImport = true,
        reportUndefinedVariable = true,
      },
    },
  },
})
