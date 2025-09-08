return {
  {
    'nvim-mini/mini.nvim',
    config = function()
      require('mini.tabline').setup({})
      require('mini.statusline').setup({})
      -- require('mini.pairs').setup({})
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
