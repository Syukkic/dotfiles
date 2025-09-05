vim.lsp.config('rust_analyzer', {

  cmd = { 'rust-analyzer' },

  filetypes = { 'rust' },

  root_markers = { { 'Cargo.toml', 'Cargo.lock' } },

  settings = {
    ['rust-analyzer'] = {
      assist = {
        importGranularity = 'module',
        importPrefix = 'self',
      },
      check = {
        command = 'clippy',
      },
      cargo = {
        allFeatures = true,
        loadOutDirsFromCheck = true,
        runBuildScripts = true,
      },
      checkOnSave = true,
      diagnostics = {
        enable = true,
      },
      inlayHints = {
        enable = true,
        showParameterNames = true,
        parameterHintsPrefix = '<- ',
        otherHintsPrefix = '=> ',
      },
      rustfmt = {
        rangeFormatting = {
          enable = true,
        },
      },
    },
  },
})
