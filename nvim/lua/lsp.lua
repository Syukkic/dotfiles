local methods = vim.lsp.protocol.Methods
local M = {}

local function on_attach(client, bufnr)
  ---@param lhs string
  ---@param rhs string|function
  ---@param desc string
  ---@param mode? string|string[]
  local function keymap(lhs, rhs, desc, mode)
    mode = mode or 'n'
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end


  keymap( '<leader>l', '<cmd>Outline<CR>', 'Toggle Outline')
  keymap('<leader>e', vim.diagnostic.open_float, 'Show diagnostics float')
  keymap('[d', function()
    vim.diagnostic.jump({ count = -1, float = true })
  end, 'Previous diagnostic')
  keymap(']d', function()
    vim.diagnostic.jump({ count = 1, float = true })
  end, 'Next diagnostic')
  keymap('<leader>q', vim.diagnostic.setloclist, 'Diagnostics to loclist')
  keymap('gr', '<cmd>Telescope lsp_references<CR>', 'Go to References')
  keymap('gd', '<cmd>Telescope lsp_definitions<CR>', 'Go to Definitions')
  keymap('gtd', '<cmd>Telescope lsp_type_definitions<CR>', 'Go to type definition')
  keymap('gds', '<cmd>Telescope lsp_document_symbols<CR>', 'Document symbols')
  keymap('ge', '<cmd>Telescope diagnostics<CR>', 'Diagnostics list')
  keymap('gi', '<cmd>Telescope lsp_implementations<CR>', 'Implementations')
  keymap('K', vim.lsp.buf.hover, 'Hover')
  keymap('<C-k>', vim.lsp.buf.signature_help, 'Signature help')
  keymap('<leader>wa', vim.lsp.buf.add_workspace_folder, 'Add workspace folder')
  keymap('<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Remove workspace folder')
  keymap('<leader>r', vim.lsp.buf.rename, 'Rename symbol')
  keymap('<leader>a', vim.lsp.buf.code_action, 'Code action', { 'n', 'v' })
  keymap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, 'List workspace folders')
  keymap('<leader>f', function()
    vim.lsp.buf.format({ async = true })
  end, 'Format buffer')
  keymap('<leader>h', function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
  end, 'Toggle inlay hints')

  if client:supports_method(methods.textDocument_signatureHelp) then
        keymap('<C-k>', function()
            -- Close the completion menu first (if open).
            if require('blink.cmp.completion.windows.menu').win:is_open() then
                require('blink.cmp').hide()
            end

            vim.lsp.buf.signature_help()
        end, 'Signature help', 'i')
    end

    if client:supports_method(methods.textDocument_documentHighlight) then
        local under_cursor_highlights_group =
            vim.api.nvim_create_augroup('mariasolos/cursor_highlights', { clear = false })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'InsertLeave' }, {
            group = under_cursor_highlights_group,
            desc = 'Highlight references under the cursor',
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ 'CursorMoved', 'InsertEnter', 'BufLeave' }, {
            group = under_cursor_highlights_group,
            desc = 'Clear highlight references',
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
        })
    end
end


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

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'Configure LSP keymaps',
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        -- I don't think this can happen but it's a wild world out there.
        if not client then
            return
        end

        on_attach(client, args.buf)
    end,
})

-- Set up LSP servers.
vim.api.nvim_create_autocmd({ 'BufReadPre', 'BufNewFile' }, {
  once = true,
  callback = function()
    local server_configs = vim
      .iter(vim.api.nvim_get_runtime_file('lsp/*.lua', true))
      :map(function(file)
        return vim.fn.fnamemodify(file, ':t:r')
      end)
      :totable()
    vim.lsp.enable(server_configs)
  end,
})


return M
