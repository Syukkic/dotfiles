return {
  {
    'williamboman/mason.nvim',
    lazy = false,
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'saghen/blink.cmp',
    },

    config = function()
      local mason = require('mason')
      local mason_lspconfig = require('mason-lspconfig')
      local mason_tool_installer = require('mason-tool-installer')
      mason.setup({
        ui = {
          icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗',
          },
        },
      })
      mason_lspconfig.setup({
        ensure_installed = {
          'bashls',
          'beancount',
          'clangd',
          'cssls',
          'emmet_language_server',
          'eslint',
          'gopls',
          'html',
          'jsonls',
          'lua_ls',
          'marksman',
          'pyright',
          'rust_analyzer',
          'tinymist',
          'ts_ls',
          'yamlls',
        },
        automatic_enable = true,
      })
      mason_tool_installer.setup({
        ensure_installed = {
          'black',
          'clangd',
          'djlint',
          'isort',
          'prettier',
          'stylua',
        },
      })
    end,
  },
}
