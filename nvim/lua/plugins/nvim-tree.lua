return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local nt = require('nvim-tree')

    nt.setup({
      sort = {
        sorter = 'case_sensitive',
      },
      view = {
        width = 30,
        side = 'left',
        relativenumber = true,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = false,
        custom = { '.git', 'node_modules', '.cache', '.venv', '__pycache__' },
      },
      actions = {
        open_file = {
          quit_on_open = true,
        },
      },
    })

    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    vim.opt.termguicolors = true

    -- local api = require('nvim-tree.api')
    -- vim.keymap.set('n', 'h', api.node.navigate.parent_close)
    -- vim.keymap.set('n', 'l', api.node.open.edit)
    vim.keymap.set('n', '<leader>mo', ':NvimTreeToggle<CR>', { silent = true, noremap = true })
  end,
}
