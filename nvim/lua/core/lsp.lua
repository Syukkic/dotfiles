-- lsp
--------------------------------------------------------------------------------
-- See https://gpanders.com/blog/whats-new-in-neovim-0-11/ for a nice overview
-- of how the lsp setup works in neovim 0.11+.

-- This actually just enables the lsp servers.
-- The configuration is found in the lsp folder inside the nvim config folder,
-- so in ~.config/lsp/lua_ls.lua for lua_ls, for example.

vim.lsp.enable({ 'lua_ls', 'rust_analyzer', 'pyright', 'ts_ls', 'svelte' })


vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'noinsert', 'popup' }

    vim.keymap.set('i', '<C-Space>', vim.lsp.completion.get, { buffer = event.buf })

    vim.keymap.set('i', '<CR>', function()
      if vim.fn.pumvisible() == 1 then
        return vim.api.nvim_replace_termcodes('<C-y>', true, true, true)
      else
        return vim.api.nvim_replace_termcodes('<CR>', true, true, true)
      end
    end, { expr = true, buffer = event.buf })

    -- vim.keymap.set('i', '<Tab>', function()
    --   if vim.fn.pumvisible() == 1 then
    --     return vim.api.nvim_replace_termcodes('<C-n>', true, true, true)
    --   else
    --     return vim.api.nvim_replace_termcodes('<Tab>', true, true, true)
    --   end
    -- end, { expr = true, buffer = event.buf })

    -- vim.keymap.set('i', '<S-Tab>', function()
    --   if vim.fn.pumvisible() == 1 then
    --     return vim.api.nvim_replace_termcodes('<C-p>', true, true, true)
    --   else
    --     return vim.api.nvim_replace_termcodes('<S-Tab>', true, true, true)
    --   end
    -- end, { expr = true, buffer = event.buf })

    local opts = { buffer = event.buf }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>a', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format({ async = true })
    end, opts)
    vim.keymap.set('n', '<leader>i', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ event.buf }), { event.buf })
    end, opts)

    local function client_supports_method(client, method, bufnr)
      if vim.fn.has('nvim-0.11') == 1 then
        return client:supports_method(method, bufnr)
      else
        return client.supports_method(method, { bufnr = bufnr })
      end
    end

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if
      client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
    then
      local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })

      -- When cursor stops moving: Highlights all instances of the symbol under the cursor
      -- When cursor moves: Clears the highlighting
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      -- When LSP detaches: Clears the highlighting
      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = 'lsp-highlight', buffer = event2.buf })
        end,
      })
    end
  end,
})

-- Diagnostics
vim.diagnostic.config({
  virtual_lines = true,
  -- virtual_text = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,

  float = {
    border = 'rounded',
    source = true,
  },
  signs = {
    -- text = {
    --   [vim.diagnostic.severity.ERROR] = '󰅚 ',
    --   [vim.diagnostic.severity.WARN] = '󰀪 ',
    --   [vim.diagnostic.severity.INFO] = '󰋽 ',
    --   [vim.diagnostic.severity.HINT] = '󰌶 ',
    -- },
    numhl = {
      [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
      [vim.diagnostic.severity.WARN] = 'WarningMsg',
    },
  },
  vim.keymap.set('n', '[d', function()
    vim.diagnostic.jump({ count = -1, float = true })
  end),
  vim.keymap.set('n', ']d', function()
    vim.diagnostic.jump({ count = 1, float = true })
  end),
})
