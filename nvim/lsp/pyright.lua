vim.lsp.config('pyright', {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  settings = {
    python = {
      analysis = {
        typecheckingmode = 'basic', -- "off", "basic", or "strict"
        autosearchpaths = true,
        uselibrarycodefortypes = true,
        stubpath = 'typings',
        diagnosticseverityoverrides = {
          reportattributeaccessissue = 'none', -- or 'warning'
        },
        reportmissingimports = true,
        reportunusedimport = true,
        reportundefinedvariable = true,
      },
    },
  },
})

