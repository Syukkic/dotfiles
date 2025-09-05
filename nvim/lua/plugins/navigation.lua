return { -- Fuzz Finder
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    version = false,
    keys = {
      {
        '<C-p>',
        '<cmd>Telescope find_files<cr>',
        desc = 'Telescope find files',
      },
      {
        '<C-g>',
        '<cmd>Telescope live_grep<cr>',
        desc = 'Telescope live grep',
      },
      {
        '<C-b>',
        '<cmd>Telescope buffers<cr>',
        desc = 'Telescope buffers',
      },
      {
        '<C-h>',
        '<cmd>Telescope help_tags<cr>',
        desc = 'Telescope help tags',
      },
    },
    opts = {
      defaults = {
        layout_strategy = 'horizontal',
        layout_config = {
          prompt_position = 'bottom',
        },
        sorting_strategy = 'descending',
        mappings = {
          i = {
            ['<C-l>'] = require('telescope.actions.layout').toggle_preview,
          },
        },
        preview = {
          hide_on_startup = true, -- hide previewer when picker starts
        },
      },
    },
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons' },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      ensure_installed = {
        'bash',
        'beancount',
        'fish',
        'go',
        'haskell',
        'html',
        'javascript',
        'lua',
        'markdown',
        'python',
        'rust',
        'sql',
        'svelte',
        'tsx',
        'typescript',
        'vim',
        'zig',
        'htmldjango',
      },
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('treesitter-context').setup({
        enable = true,
        max_lines = 3,
        min_window_height = 0,
        line_numbers = true,
        multiline_threshold = 20,
        trim_scope = 'outer',
        mode = 'cursor',
        separator = nil,
        zindex = 20,
      })
    end,
  },
  {
    'echasnovski/mini.nvim',
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
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = { icons_enabled = true },
        sections = {
          lualine_c = {
            {
              'filename',
              file_status = true, -- displays file status (readonly status, modified status)
              path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
            },
          },
        },
      })
    end,
  },
}
