return {
  {
    'ellisonleao/gruvbox.nvim',
    config = function()
      require('gruvbox').setup({
        terminal_colors = true, -- add neovim terminal colors
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = false,
          emphasis = false,
          comments = true,
          operators = false,
          folds = false,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = 'soft', -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = false,
      })
      vim.o.background = 'dark'
      vim.cmd('colorscheme gruvbox')
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
  -- {
  --   'rrethy/base16-nvim',
  --   lazy = false, -- load at start
  --   priority = 1000, -- load first
  --   config = function()
  --     vim.o.background = 'light'
  --     -- vim.cmd([[colorscheme base16-gruvbox-dark-hard]])
  --     require('base16-colorscheme').setup({
  --       base00 = '#f8f8f8',
  --       base01 = '#e5e5e5',
  --       base02 = '#b9dcdd',
  --       base03 = '#a5a5a5',
  --       base04 = '#555555',
  --       base05 = '#000f7f',
  --       base06 = '#323232',
  --       base07 = '#000000',
  --       base08 = '#257e99',
  --       base09 = '#007d00',
  --       base0a = '#af4444',
  --       base0b = '#a3182b',
  --       base0c = '#0598bc',
  --       base0d = '#785d25',
  --       base0e = '#0000ff',
  --       base0f = '#424442',
  --     })
  --     -- xxx: hi normal ctermbg=none
  --     -- make comments more prominent -- they are important.
  --     local bools = vim.api.nvim_get_hl(0, {
  --       name = 'boolean',
  --     })
  --     vim.api.nvim_set_hl(0, 'comment', bools)
  --     -- make it clearly visible which argument we're at.
  --     local marked = vim.api.nvim_get_hl(0, {
  --       name = 'pmenu',
  --     })
  --     vim.api.nvim_set_hl(0, 'lspsignatureactiveparameter', {
  --       fg = marked.fg,
  --       bg = marked.bg,
  --       ctermfg = marked.ctermfg,
  --       ctermbg = marked.ctermbg,
  --       bold = true,
  --     })
  --   end,
  --   vim.api.nvim_set_hl(0, 'Comment', { italic = false }),
  --   vim.api.nvim_set_hl(0, 'Function', { italic = false }),
  --   vim.api.nvim_set_hl(0, 'Type', { italic = false }),
  --   vim.api.nvim_set_hl(0, '@comment', { italic = false }),
  --   vim.api.nvim_set_hl(0, '@function', { italic = false }),
  --   vim.api.nvim_set_hl(0, '@type', { italic = false }),
  -- },
}
