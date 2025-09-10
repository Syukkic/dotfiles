return {
  {
    'neovim/nvim-lspconfig',
    lazy = false,
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'saghen/blink.cmp',
    },

    config = function()
      local mason = require('mason')
      local mason_lspconfig = require('mason-lspconfig')
      local mason_tool_installer = require('mason-tool-installer')
      mason.setup({
        ui = {
          icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗',
          },
        },
      })
      mason_lspconfig.setup({
        ensure_installed = {
          'bashls',
          'beancount',
          'cssls',
          'emmet_language_server',
          'html',
          'jsonls',
          'lua_ls',
          'pyright',
          'rust_analyzer',
          'ts_ls',
          'protols',
        },
        automatic_enable = true,
      })
      mason_tool_installer.setup({
        ensure_installed = {
          'black',
          'djlint',
          'isort',
          'prettier',
          'stylua',
          'eslint_d',
        },
      })

      local servers_dir = vim.fn.stdpath('config') .. '/lua/plugins/servers'
      local files = vim.fn.globpath(servers_dir, '*.lua', false, true)
      for _, file in ipairs(files) do
        local name = vim.fn.fnamemodify(file, ':t:r')
        require('plugins.servers.' .. name)
        vim.lsp.enable(name)
      end

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

          local opts = { buffer = event.buf }
          vim.keymap.set('n', '<leader>l', '<cmd>Outline<CR>', {
            desc = 'Toggle Outline',
          })
          vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
          vim.keymap.set('n', '[d', function()
            vim.diagnostic.jump({
              count = -1,
              float = true,
            })
          end)
          vim.keymap.set('n', ']d', function()
            vim.diagnostic.jump({
              count = 1,
              float = true,
            })
          end)
          vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
          vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>', { noremap = true, silent = true })
          vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', { noremap = true, silent = true })
          vim.keymap.set('n', 'ge', '<cmd>Telescope diagnostics<CR>', { noremap = true, silent = true })

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
          vim.keymap.set('n', '<leader>h', function()
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
            client
            and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
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
    end,
  },
}
