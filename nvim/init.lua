require('bootstrap')
require('config.options')

if vim.g.vscode then
  require('lazy').setup({
    spec = {},
    defaults = { lazy = false, version = false },
    checker = { enabled = false },
    performance = {
      rtp = {
        disabled_plugins = {
          'gzip',
          'netrwPlugin',
          'tarPlugin',
          'tohtml',
          'zipPlugin',
        },
      },
    },
  })
else
  require('lazy').setup({
    spec = {
      { import = 'plugins.ui' },
      { import = 'plugins.navigation' },
      { import = 'plugins.coding' },
      { import = 'plugins.utils' },
    },
    defaults = { lazy = false, version = false },
    checker = { enabled = false },
    performance = {
      rtp = {
        disabled_plugins = {
          'gzip', -- "netrwPlugin",
          'tarPlugin',
          'tohtml',
          'zipPlugin',
        },
      },
    },
  })
end

require('config.keymaps')
require('config.autocmds')
