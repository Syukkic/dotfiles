return {
  {
    'williamboman/mason.nvim',
    lazy = false,
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'neovim/nvim-lspconfig',
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
        automatic_enable = false,
        ensure_installed = {
          'bashls',
          'beancount',
          'clangd',
          'cssls',
          'emmet_language_server',
          'eslint',
          'gopls',
          'html',
          'jsonls',
          'lua_ls',
          'marksman',
          'pyright',
          'rust_analyzer',
          'tinymist',
          'ts_ls',
          'yamlls',
        },
      })

      mason_tool_installer.setup({
        ensure_installed = {
          'black',
          'clangd',
          'djlint',
          'isort',
          'prettier',
          'stylua',
        },
      })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'j-hui/fidget.nvim',
      'hedyhli/outline.nvim',
      'jose-elias-alvarez/typescript.nvim',
      'saghen/blink.cmp',
      'rafamadriz/friendly-snippets',
      {
        'folke/lazydev.nvim',
        ft = 'lua', -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
          },
        },
      },
    },
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { 'vim', 'luasnip' },
              },
              runtime = {
                version = 'LuaJIT',
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
              },
              telemetry = {
                enable = false,
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = 'Disable',
                semicolon = 'Disable',
                arrayIndex = 'Disable',
              },
            },
          },
        },
        bashls = {
          cmd = { 'bash-language-server', 'start' },
          filetypes = { 'bash', 'sh' },
        },
        rust_analyzer = {
          settings = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              runBuildScripts = true,
            },
            imports = {
              group = {
                enable = false,
              },
            },
            completion = {
              postfix = {
                enable = false,
                command = 'clippy',
              },
            },
            checkOnsave = {
              enable = true,

              allFeatures = true,
              command = 'clippy',
              extraArgs = {
                '--',
                '--no-deps',
                '-Dclippy::correctness',
                '-Dclippy::complexity',
                '-Wclippy::perf',
                '-Wclippy::pedantic',
              },
            },
            diagnostics = {
              enable = true,
            },
            inlayHints = {
              enable = true,
              showParameterNames = true,
              parameterHintsPrefix = '<- ',
              otherHintsPrefix = '=> ',
            },
            procMacro = {
              enable = true,
              ignored = {
                ['async-trait'] = { 'async_trait' },
                ['napi-derive'] = { 'napi' },
                ['async-recursion'] = { 'async_recursion' },
              },
            },
          },
        },
        taplo = {},
        ts_ls = {
          -- root_dir = function(fname)
          --   local lspconfig = require('lspconfig')
          --   return (lspconfig.util.root_pattern('package.json'))(fname)
          -- end,
          cmd = { 'typescript-language-server', '--stdio' },
          single_file_support = false,
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = 'all',
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayVariableTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = 'all',
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayVariableTypeHints = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },
        cssls = {},
        jsonls = {},
        html = {},
        svelte = {
          filetypes = { 'svelte' },
        },
        tinymist = {
          settings = {
            formatterMode = 'typstyle',
            semanticTokens = 'disable',
          },
        },
        pyright = {
          filetypes = { 'python' },
          settings = {
            python = {
              analysis = {
                typeCheckingMode = 'basic', -- "off", "basic", or "strict"
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                reportMissingImports = true,
                reportUnusedImport = true,
                reportUndefinedVariable = true,
                stubPath = 'typings',
              },
            },
          },
        },
        clangd = {
          cmd = { 'clangd', '--background-index', '--clang-tidy' },
          filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
        },
        hls = {
          cmd = { 'haskell-language-server-wrapper', '--lsp' },
          filetypes = { 'hs', 'lhs', 'haskell' },
          initializationOptions = { 'languageServerHaskell', {} },
          rootPatterns = { '*.cabal', 'stack.yaml', 'cabal.project', 'package.yaml', 'hie.yaml' },
          single_file_support = true,
          settings = {
            haskell = {
              cabalFormattingProvider = 'cabalfmt',
              formattingProvider = 'ormolu',
            },
          },
        },
        racket_langserver = {
          -- https://www.andersevenrud.net/neovim.github.io/lsp/configurations/racket_langserver/
        },
        emmet_language_server = {
          filetypes = {
            'css',
            'eruby',
            'html',
            'javascript',
            'javascriptreact',
            'less',
            'sass',
            'scss',
            'pug',
            'typescriptreact',
          },
          init_options = {
            ---@type table<string, string>
            includeLanguages = {},
            --- @type string[]
            excludeLanguages = {},
            --- @type string[]
            extensionsPath = {},
            --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
            preferences = {},
            --- @type boolean Defaults to `true`
            showAbbreviationSuggestions = true,
            --- @type "always" | "never" Defaults to `"always"`
            showExpandedAbbreviation = 'always',
            --- @type boolean Defaults to `false`
            showSuggestionsAsSnippets = false,
            --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
            syntaxProfiles = {},
            --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
            variables = {},
          },
        },
        beancount = {
          cmd = { 'beancount-language-server', '--stdio' },
          filetypes = { 'bean', 'beancount' },
          init_options = {
            journalFile = '~/personal/finance/',
            pythonPath = 'python',
          },
          root_dir = function(fname)
            return vim.fs.dirname((vim.fs.find('.git', {
              path = fname,
              upward = true,
            }))[1])
          end,
        },
        gopls = {
          settings = {
            gopls = {
              analyses = {
                unusedparams = true,
              },
              staticcheck = true,
              gofumpt = true,
            },
          },
        },
        zls = {
          settings = {
            zls = {
              semantic_tokens = 'partial',
            },
          },
        },
        css_variables = {},
      },
      inlay_hints = {
        enabled = true,
      },
    },
    config = function(_, opts)
      (require('fidget')).setup({});
      (require('outline')).setup({
        outline_window = {
          position = 'left',
        },
      })
      local lspconfig = require('lspconfig')
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local function on_attach()
        if vim.lsp.inlay_hint then
          vim.lsp.inlay_hint.enable(true, { 0 })
        end
      end
      for server, config in pairs(opts.servers) do
        -- lspconfig[server].setup(vim.tbl_deep_extend('force', {
        lspconfig[server].setup({
          capabilities = capabilities,
          on_attach = on_attach,
        }, config)
      end
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
      vim.keymap.set('n', 'td', '<cmd>Telescope diagnostics<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', 'K', vim.lsp.buf.hover)
      vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help)
      vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder)
      vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder)
      vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end)
      vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename)
      vim.keymap.set({ 'n', 'v' }, '<leader>a', vim.lsp.buf.code_action)
      vim.keymap.set('n', '<leader>f', function()
        vim.lsp.buf.format({ async = true })
      end)
      vim.keymap.set('n', '<leader>i', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 })
      end)
      -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
      -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
      -- vim.keymap.set('n', 'gr', vim.lsp.buf.references)
      -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
    end,
  },
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
      fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
    config = function(_, opts)
      require('blink.cmp').setup(opts)

      -- Extend neovim's client capabilities with the completion ones.
      vim.lsp.config('*', { capabilities = require('blink.cmp').get_lsp_capabilities(nil, true) })
    end,
  },
  {
    'nvimtools/none-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local null_ls = require('null-ls')

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.djlint.with({
            extra_args = { '--quiet', '--reformat', '--indent=2', '-' },
            filetypes = { 'html', 'jinja', 'django', 'htmldjango' },
          }),
          null_ls.builtins.diagnostics.djlint.with({
            extra_args = { '--quiet' },
            filetypes = { 'html', 'jinja', 'django', 'htmldjango' },
          }),
          null_ls.builtins.formatting.black.with({
            extra_args = { '--fast', '--skip-string-normalization' },
            filetypes = { 'python' },
          }),
          null_ls.builtins.formatting.isort.with({
            filetypes = { 'python' },
          }),
          null_ls.builtins.formatting.shfmt.with({
            filetypes = { 'sh' },
          }),
          null_ls.builtins.formatting.prettier.with({
            extra_args = { '--single-quote' },
            filetypes = {
              'javascript',
              'typescript',
              'typescriptreact',
              'javascriptreact',
              'css',
              'html',
              'json',
              'yaml',
              'markdown',
              'svelte',
            },
          }),
          null_ls.builtins.formatting.stylua.with({
            filetypes = { 'lua' },
          }),
          null_ls.builtins.formatting.ocamlformat.with({
            filetypes = { 'ocaml' },
          }),
        },
      })
    end,
  },
  {
    'saecki/crates.nvim',
    event = { 'BufRead Cargo.toml' },
    config = function()
      (require('crates')).setup({})
    end,
  },
}
