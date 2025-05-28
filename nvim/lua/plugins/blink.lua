return {
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
        documentation = { auto_show = true },
      },
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
      },
      fuzzy = { implementation = 'prefer_rust_with_warning' },
    }
	}
