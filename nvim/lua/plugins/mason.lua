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
          'cssls',
          'emmet_language_server',
          'html',
          'jsonls',
          'lua_ls',
          'pyright',
          'rust_analyzer',
          'ts_ls',
        },
        automatic_enable = true,
      })
      mason_tool_installer.setup({
        ensure_installed = {
          'black',
          'djlint',
          'isort',
          'prettier',
          'stylua',
          'eslint_d',
        },
      })
    end,
  },
}
