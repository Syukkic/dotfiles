-- plugins/coding.lua
return {
	-- LSP
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/cmp-nvim-lsp",
			"j-hui/fidget.nvim",
		},
		opts = {
			servers = {
				lua_ls = {
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							workspace = { checkThirdParty = false },
							telemetry = { enable = false },
							diagnostics = {
								globals = { "vim", "luasnip" }, -- Recognize the `vim` global
							},
						},
					},
				},
				rust_analyzer = {
					settings = {
						["rust-analyzer"] = {
							cargo = {
								allFeatures = true,
							},
							imports = {
								group = {
									enable = false,
								},
							},
							completion = {
								postfix = {
									enable = false,
									command = "clippy",
								},
							},
							checkOnsave = {
								enable = true,
							},
							diagnostics = {
								enable = true,
							},
							inlayHints = {
								enable = true,
								showParameterNames = true,
								parameterHintsPrefix = "<- ",
								otherHintsPrefix = "=> ",
							},
						},
					},
				},
				ts_ls = {
					root_dir = function(fname)
						local lspconfig = require("lspconfig")
						return lspconfig.util.root_pattern("package.json")(fname)
					end,
					cmd = { "typescript-language-server", "--stdio" },
					single_file_support = false,
				},
				denols = {
					cmd = { "deno", "lsp" },
					filetypes = {
						"javascript",
						"javascriptreact",
						"typescript",
						"typescriptreact",
					},
					root_dir = function(fname)
						local lspconfig = require("lspconfig")
						return lspconfig.util.root_pattern("deno.json", "deno.jsonc")(fname)
					end,
					init_options = {
						lint = true,
						unstable = true,
					},
				},
				tinymist = {
					settings = {
						formatterMode = "typstyle",
						-- exportPdf = "onType",
						semanticTokens = "disable",
					},
				},
				jedi_language_server = {
					filetypes = { "python" },
				},
				clangd = {
					cmd = { "clangd", "--background-index", "--clang-tidy" },
					filetypes = { "c", "cpp", "objc", "objcpp" },
				},
				hls = {
					cmd = { "haskell-language-server-wrapper", "--lsp" },
					filetypes = { "hs", "lhs", "haskell" },
					initializationOptions = { "languageServerHaskell", {} },
					rootPatterns = { "*.cabal", "stack.yaml", "cabal.project", "package.yaml", "hie.yaml" },
					single_file_support = true,
					settings = {
						haskell = {
							cabalFormattingProvider = "cabalfmt",
							formattingProvider = "ormolu",
						},
					},
				},
				emmet_language_server = {
					filetypes = {
						"css",
						"eruby",
						"html",
						"javascript",
						"javascriptreact",
						"less",
						"sass",
						"scss",
						"pug",
						"typescriptreact",
					},
				},
				beancount = {
					cmd = { "beancount-language-server", "--stdio" },
					filetypes = { "bean", "beancount" },
					init_options = {
						journalFile = "~/Repos/Mine/finance",
						pythonPath = "python",
					},
					root_dir = function(fname)
						return vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
					end,
				},
			},
		},
		config = function(_, opts)
			require("fidget").setup({})
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"bashls",
					"clangd",
					"cssls",
					"beancount",
					"emmet_language_server",
					"hls",
					"html",
					"jedi_language_server",
					"jsonls",
					"lua_ls",
					"rust_analyzer",
					"tinymist",
					"ts_ls",
					"yamlls",
				},
				automatic_installation = true,
			})
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			for server, config in pairs(opts.servers) do
				lspconfig[server].setup(vim.tbl_deep_extend("force", {
					capabilities = capabilities,
				}, config))
			end

			-- -- test hsl of ghcup
			-- lspconfig.hls.setup({
			-- 	capabilities = require("cmp_nvim_lsp").default_capabilities(),
			-- 	filetypes = { "haskell", "lhaskell" },
			-- 	settings = {
			-- 		haskell = {
			-- 			checkProject = true,
			-- 			formatOnImportOn = true,
			-- 			hlintOn = true,
			-- 			maxCompletions = 40,
			-- 		},
			-- 	},
			-- })

			-- Global mappings.
			-- See `:help vim.diagnostic.*` for documentation on any of the below functions
			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
			vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
			vim.keymap.set("n", "gd", vim.lsp.buf.definition)
			vim.keymap.set("n", "K", vim.lsp.buf.hover)
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation)
			vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help)
			vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder)
			vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder)
			vim.keymap.set("n", "<leader>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end)
			vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename)
			vim.keymap.set({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action)
			vim.keymap.set("n", "gr", vim.lsp.buf.references)
			vim.keymap.set("n", "<leader>f", function()
				vim.lsp.buf.format({
					async = true,
				})
			end)
			vim.keymap.set("n", "<leader>i", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 })
			end)
		end,
	},

	-- autocomplete
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim",
		},
		opts = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")

			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip").filetype_extend("typescript", { "tsdoc" })
			require("luasnip").filetype_extend("javascript", { "jsdoc" })
			require("luasnip").filetype_extend("lua", { "luadoc" })
			require("luasnip").filetype_extend("python", { "pydoc" })
			require("luasnip").filetype_extend("rust", { "rustdoc" })

			vim.o.completeopt = "menu,menuone,noinsert,noselect"
			-- return {
			cmp.setup({
				window = {
					documentation = false,
				},
				sorting = {
					priority_weight = 2,
					comparators = {
						-- 自定義方法類型排序
						function(entry1, entry2)
							local kind1 = entry1:get_kind()
							local kind2 = entry2:get_kind()
							local method_priority = {
								[cmp.lsp.CompletionItemKind.Method] = 1, -- 方法
								[cmp.lsp.CompletionItemKind.Function] = 2, -- 函數
								[cmp.lsp.CompletionItemKind.Constructor] = 3, -- 構造函數
							}
							local priority1 = method_priority[kind1] or 100
							local priority2 = method_priority[kind2] or 100
							if priority1 ~= priority2 then
								return priority1 < priority2
							end
						end,
						cmp.config.compare.offset,
						cmp.config.compare.exact,
						cmp.config.compare.score,
						cmp.config.compare.recently_used,
						cmp.config.compare.kind,
						cmp.config.compare.sort_text,
						cmp.config.compare.length,
						cmp.config.compare.order,
					},
				},
				formatting = {
					format = lspkind.cmp_format({
						-- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
						mode = "symbol_text",
						maxwidth = {
							menu = 50, -- leading text (labelDetails)
							abbr = 50, -- actual suggestion item
						},
						ellipsis_char = "...",
						show_labelDetails = true,
						before = function(entry, vim_item)
							return vim_item
						end,
					}),
				},
				snippet = {
					-- REQUIRED by nvim-cmp. get rid of it once we can
					expand = function(args)
						require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-m>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					-- Accept currently selected item.
					-- Set `select` to `false` to only confirm explicitly selected items.
					["<CR>"] = cmp.mapping.confirm({
						select = true,
					}),

					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							-- If in insert mode and the cursor is
							-- at the beginning of the line
							-- or before a whitespace character, insert a tab
							local col = vim.fn.col(".") - 1
							if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
								vim.api.nvim_feedkeys(
									vim.api.nvim_replace_termcodes("<Tab>", true, true, true),
									"n",
									true
								)
							else
								fallback() -- Pass through if no action is possible
							end
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							vim.api.nvim_feedkeys(
								vim.api.nvim_replace_termcodes("<S-Tab>", true, true, true),
								"n",
								true
							)
							fallback() -- Pass through if no action is possible
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
					-- { name = "conjure" },
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},
	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		config = function()
			require("crates").setup()
		end,
	},
}
