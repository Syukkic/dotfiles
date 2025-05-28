return {
  'williamboman/mason.nvim',
  lazy = false,
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    -- 'hrsh7th/cmp-nvim-lsp',
    'neovim/nvim-lspconfig',
    "saghen/blink.cmp",
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
      automatic_enable = false,
      -- servers for mason to install
      ensure_installed = {
        'bashls',
        'beancount',
        'clangd',
        'cssls',
        'emmet_language_server',
        'emmet_ls',
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
}
