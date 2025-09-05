return {
  {
    'saghen/blink.cmp',
    dependencies = 'L3MON4D3/LuaSnip',
    build = 'cargo build --release',
    version = '1.*',
    event = 'InsertEnter',
    opts = {
      keymap = {
        ['<CR>'] = { 'accept', 'fallback' },
        ['<C-\\>'] = { 'hide', 'fallback' },
        ['<C-n>'] = { 'select_next', 'show' },
        ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
        ['<C-p>'] = { 'select_prev' },
        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
      },
      completion = {
        list = {
          -- Insert items while navigating the completion list.
          selection = { preselect = false, auto_insert = true },
          max_items = 10,
        },
        menu = {
          draw = {
            columns = {
              { 'kind_icon' },
              { 'label', 'label_description', gap = 1 },
              { 'kind' },
              { 'source_name' },
            },
          },
        },
        documentation = {
          window = {
            border = nil,
            scrollbar = true,
            winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc',
          },
          auto_show = true,
          auto_show_delay_ms = 500,
        },
      },
      signature = { enabled = true },
      snippets = { preset = 'luasnip' },
      -- Disable command line completion:
      cmdline = { enabled = false },
      sources = {
        -- Disable some sources in comments and strings.
        default = function()
          local sources = { 'lsp', 'buffer' }
          local ok, node = pcall(vim.treesitter.get_node)

          if ok and node then
            if not vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
              table.insert(sources, 'path')
            end
            if node:type() ~= 'string' then
              table.insert(sources, 'snippets')
            end
          end
          return sources
        end,
        per_filetype = {
          codecompanion = { 'codecompanion', 'buffer' },
        },
      },
      fuzzy = { implementation = 'prefer_rust' },
    },
  },
}
