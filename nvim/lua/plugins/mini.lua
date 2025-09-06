return {
  {
    'nvim-mini/mini.tabline',
    version = false,
    config = function()
      require('mini.tabline').setup()
    end,
  },
  {
    'nvim-mini/mini.statusline',
    version = false,
    config = function()
      require('mini.statusline').setup()
    end,
  },
  {
    'nvim-mini/mini.pairs',
    version = '*',
    config = function()
      require('mini.pairs').setup()
    end,
  },
  {
    'nvim-mini/mini.files',
    version = '*',
    config = function()
      require('mini.files').setup({
        windows = {
          -- Maximum number of windows to show side by side
          max_number = math.huge,
          -- Whether to show preview of file/directory under cursor
          preview = true,
          -- Width of focused window
          width_focus = 50,
          -- Width of non-focused window
          width_nofocus = 15,
          -- Width of preview window
          width_preview = 60,
        },
      })

      vim.keymap.set('n', '<leader>mo', ':lua MiniFiles.open()<cr>')
      vim.keymap.set('n', '<leader>mc', ':lua MiniFiles.close()<cr>')
    end,
  },
}
