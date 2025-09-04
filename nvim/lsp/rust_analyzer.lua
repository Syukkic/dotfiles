-- local blink = require('blink.cmp')

return {
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
  -- capabilities = vim.tbl_deep_extend(
  --   'force',
  --   {},
  --   vim.lsp.protocol.make_client_capabilities(),
  --   blink.get_lsp_capabilities(),
  --   {
  --     fileOperations = {
  --       didRename = true,
  --       willRename = true,
  --     },
  --   }
  -- ),
}
