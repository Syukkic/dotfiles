return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      -- "hrsh7th/cmp-nvim-lsp",
      'j-hui/fidget.nvim',
      'hedyhli/outline.nvim',
      'jose-elias-alvarez/typescript.nvim',
      'saghen/blink.cmp',
      'rafamadriz/friendly-snippets',
    },
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              runtime = {
                version = 'LuaJIT',
              },
              workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
              },
              telemetry = {
                enable = false,
              },
              diagnostics = {
                globals = { 'vim', 'luasnip' },
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
        html = {},
        -- denols = {
        --   cmd = { 'deno', 'lsp' },
        --   filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
        --   root_dir = function(fname)
        --     local lspconfig = require('lspconfig')
        --     return (lspconfig.util.root_pattern('deno.json', 'deno.jsonc'))(fname)
        --   end,
        --   init_options = {
        --     lint = true,
        --     unstable = true,
        --   },
        --   settings = {
        --     deno = {
        --       inlayHints = {
        --         parameterNames = {
        --           enabled = 'all',
        --           suppressWhenArgumentMatchesName = true,
        --         },
        --         parameterTypes = {
        --           enabled = true,
        --         },
        --         variableTypes = {
        --           enabled = true,
        --           suppressWhenTypeMatchesName = true,
        --         },
        --         propertyDeclarationTypes = {
        --           enabled = true,
        --         },
        --         functionLikeReturnTypes = {
        --           enable = true,
        --         },
        --         enumMemberValues = {
        --           enabled = true,
        --         },
        --       },
        --     },
        --   },
        --   inlayHints = {
        --     enabled = true,
        --   },
        -- },
        svelte = {
          filetypes = { 'svelte' },
        },
        tinymist = {
          settings = {
            formatterMode = 'typstyle',
            semanticTokens = 'disable',
          },
        },
        jedi_language_server = {
          filetypes = { 'python' },
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
      });
      (require('mason')).setup();
      (require('mason-lspconfig')).setup({
        ensure_installed = {
          'bashls',
          'beancount',
          'clangd',
          'cssls',
          'emmet_language_server',
          'gopls',
          'hls',
          'html',
          'jedi_language_server',
          'jsonls',
          'lua_ls',
          'pyright',
          'rust_analyzer',
          'tinymist',
          'ts_ls',
          'yamlls',
          'zls',
        },
        automatic_installation = true,
      })
      local lspconfig = require('lspconfig')
      -- local capabilities = (require("cmp_nvim_lsp")).default_capabilities()
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local function on_attach()
        if vim.lsp.inlay_hint then
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 })
        end
      end
      for server, config in pairs(opts.servers) do
        lspconfig[server].setup(config)
        lspconfig[server].setup(vim.tbl_deep_extend('force', {
          capabilities = capabilities,
          on_attach = on_attach,
        }, config))
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
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help)
      vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder)
      vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder)
      vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end)
      vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename)
      vim.keymap.set({ 'n', 'v' }, '<leader>a', vim.lsp.buf.code_action)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references)
      vim.keymap.set('n', '<leader>f', function()
        vim.lsp.buf.format({
          async = true,
        })
      end)
      vim.keymap.set('n', '<leader>i', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 })
      end)
    end,
  },
  -- {
  -- 	"hrsh7th/nvim-cmp",
  -- 	event = "InsertEnter",
  -- 	dependencies = {
  -- 		"hrsh7th/cmp-buffer",
  -- 		"hrsh7th/cmp-path",
  -- 		"hrsh7th/cmp-nvim-lua",
  -- 		"L3MON4D3/LuaSnip",
  -- 		"saadparwaiz1/cmp_luasnip",
  -- 		"rafamadriz/friendly-snippets",
  -- 		"onsails/lspkind.nvim",
  -- 	},
  -- 	opts = function()
  -- 		local cmp = require("cmp")
  -- 		local luasnip = require("luasnip")
  -- 		local lspkind = require("lspkind");
  -- 		(require("luasnip.loaders.from_vscode")).lazy_load();
  -- 		(require("luasnip")).filetype_extend("typescript", { "tsdoc" });
  -- 		(require("luasnip")).filetype_extend("javascript", { "jsdoc" });
  -- 		(require("luasnip")).filetype_extend("lua", { "luadoc" });
  -- 		(require("luasnip")).filetype_extend("python", { "pydoc" });
  -- 		(require("luasnip")).filetype_extend("rust", { "rustdoc" })
  -- 		vim.o.completeopt = "menu,menuone,noinsert,noselect"
  -- 		cmp.setup({
  -- 			formatting = {
  -- 				format = lspkind.cmp_format({
  -- 					mode = "symbol_text",
  -- 					maxwidth = {
  -- 						menu = 50,
  -- 						abbr = 50,
  -- 					},
  -- 					ellipsis_char = "...",
  -- 					show_labelDetails = true,
  -- 					before = function(entry, vim_item)
  -- 						return vim_item
  -- 					end,
  -- 				}),
  -- 			},
  -- 			snippet = {
  -- 				expand = function(args)
  -- 					(require("luasnip")).lsp_expand(args.body)
  -- 				end,
  -- 			},
  -- 			mapping = cmp.mapping.preset.insert({
  -- 				["<C-b>"] = cmp.mapping.scroll_docs(-4),
  -- 				["<C-f>"] = cmp.mapping.scroll_docs(4),
  -- 				["<C-m>"] = cmp.mapping.complete(),
  -- 				["<C-e>"] = cmp.mapping.abort(),
  -- 				["<CR>"] = cmp.mapping.confirm({
  -- 					select = true,
  -- 				}),
  -- 				["<Tab>"] = cmp.mapping(function(fallback)
  -- 					if cmp.visible() then
  -- 						cmp.select_next_item()
  -- 					elseif luasnip.expand_or_jumpable() then
  -- 						luasnip.expand_or_jump()
  -- 					else
  -- 						local col = vim.fn.col(".") - 1
  -- 						if col == 0 or ((vim.fn.getline(".")):sub(col, col)):match("%s") then
  -- 							vim.api.nvim_feedkeys(
  -- 								vim.api.nvim_replace_termcodes("<Tab>", true, true, true),
  -- 								"n",
  -- 								true
  -- 							)
  -- 						else
  -- 							fallback()
  -- 						end
  -- 					end
  -- 				end, { "i", "s" }),
  -- 				["<S-Tab>"] = cmp.mapping(function(fallback)
  -- 					if cmp.visible() then
  -- 						cmp.select_prev_item()
  -- 					elseif luasnip.jumpable(-1) then
  -- 						luasnip.jump(-1)
  -- 					else
  -- 						vim.api.nvim_feedkeys(
  -- 							vim.api.nvim_replace_termcodes("<S-Tab>", true, true, true),
  -- 							"n",
  -- 							true
  -- 						)
  -- 						fallback()
  -- 					end
  -- 				end, { "i", "s" }),
  -- 			}),
  -- 			sources = cmp.config.sources({
  -- 				{
  -- 					name = "nvim_lsp",
  -- 				},
  -- 				{
  -- 					name = "luasnip",
  -- 				},
  -- 				{
  -- 					name = "path",
  -- 				},
  -- 			}, { {
  -- 				name = "buffer",
  -- 			} }),
  -- 		})
  -- 	end,
  -- },
  {
    'saecki/crates.nvim',
    event = { 'BufRead Cargo.toml' },
    config = function()
      (require('crates')).setup()
    end,
  },
  {
    'saghen/blink.cmp',
    dependencies = 'LuaSnip',
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
    },
    config = function(_, opts)
      require('blink.cmp').setup(opts)

      -- Extend neovim's client capabilities with the completion ones.
      vim.lsp.config('*', { capabilities = require('blink.cmp').get_lsp_capabilities(nil, true) })
    end,
  },
}
