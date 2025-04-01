-- plugins/coding.lua
return {
	-- LSP
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			-- "hrsh7th/cmp-nvim-lsp",
			"j-hui/fidget.nvim",
			"hedyhli/outline.nvim",
			"jose-elias-alvarez/typescript.nvim",
			"saghen/blink.cmp",
			"rafamadriz/friendly-snippets",
		},
		opts = {
			servers = {
				lua_ls = {
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							workspace = {
								library = vim.api.nvim_get_runtime_file("", true),
							},
							telemetry = { enable = false },
							diagnostics = {
								globals = { "vim", "luasnip" }, -- Recognize the `vim` global
							},
							hint = {
								enable = true,
								setType = false,
								paramType = true,
								paramName = "Disable",
								semicolon = "Disable",
								arrayIndex = "Disable",
							},
						},
					},
				},
				rust_analyzer = {
					settings = {
						-- ["rust-analyzer"] = {
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
								command = "clippy",
							},
						},
						checkOnsave = {
							enable = true,
							allFeatures = true,
							command = "clippy",
							extraArgs = {
								"--",
								"--no-deps",
								"-Dclippy::correctness",
								"-Dclippy::complexity",
								"-Wclippy::perf",
								"-Wclippy::pedantic",
							},
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
						procMacro = {
							enable = true,
							ignored = {
								["async-trait"] = { "async_trait" },
								["napi-derive"] = { "napi" },
								["async-recursion"] = { "async_recursion" },
							},
						},
					},
					-- },
				},
				ts_ls = {
					root_dir = function(fname)
						local lspconfig = require("lspconfig")
						return lspconfig.util.root_pattern("package.json")(fname)
					end,
					cmd = { "typescript-language-server", "--stdio" },
					single_file_support = false,
					settings = {
						typescript = {
							inlayHints = {
								includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all'
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
								includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all'
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
					settings = {
						deno = {
							inlayHints = {
								parameterNames = { enabled = "all", suppressWhenArgumentMatchesName = true },
								parameterTypes = { enabled = true },
								variableTypes = { enabled = true, suppressWhenTypeMatchesName = true },
								propertyDeclarationTypes = { enabled = true },
								functionLikeReturnTypes = { enable = true },
								enumMemberValues = { enabled = true },
							},
						},
					},
					inlayHints = {
						enabled = true,
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
				-- pyright = {
				-- 	filetypes = { "python" },
				-- },
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
							semantic_tokens = "partial",
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
			require("fidget").setup({})
			require("outline").setup({
				outline_window = {
					position = "left",
				},
			})
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"bashls",
					"beancount",
					"clangd",
					"cssls",
					"emmet_language_server",
					"gopls",
					"hls",
					"html",
					"jedi_language_server",
					"jsonls",
					"lua_ls",
					"pyright",
					"rust_analyzer",
					"tinymist",
					"ts_ls",
					"yamlls",
					"zls",
				},
				automatic_installation = true,
			})
			local lspconfig = require("lspconfig")
			-- local capabilities = require("cmp_nvim_lsp").default_capabilities()

			for server, config in pairs(opts.servers) do
				config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
				lspconfig[server].setup(config)
				-- lspconfig[server].setup(vim.tbl_deep_extend("force", {
				-- 	-- print(server),
				-- 	capabilities = capabilities,
				-- }, config))
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

			-- toggle outline [ hedyhli/outline.nvim ]
			vim.keymap.set("n", "<leader>l", "<cmd>Outline<CR>", { desc = "Toggle Outline" })
			-- Global mappings.
			-- See `:help vim.diagnostic.*` for documentation on any of the below functions
			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
			vim.keymap.set("n", "[d", function()
				vim.diagnostic.jump({ count = -1, float = true })
			end)
			vim.keymap.set("n", "]d", function()
				vim.diagnostic.jump({ count = 1, float = true })
			end)
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

	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = { "rafamadriz/friendly-snippets" },
		event = { "LspAttach" },

		version = "1.*",

		opts = {
			-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
			-- 'super-tab' for mappings similar to vscode (tab to accept)
			-- 'enter' for enter to accept
			-- 'none' for no mappings
			--
			-- All presets have the following mappings:
			-- C-space: Open menu or open docs if already open
			-- C-n/C-p or Up/Down: Select next/previous item
			-- C-e: Hide menu
			-- C-k: Toggle signature help (if signature.enabled = true)
			--
			-- See :h blink-cmp-config-keymap for defining your own keymap
			keymap = {
				preset = "default",
				["<C-x>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide", "fallback" },
				["<Enter>"] = { "select_and_accept" },
				p

				["<Tab>"] = {
					function(cmp)
						if cmp.snippet_active() then
							return cmp.accept()
						else
							return cmp.select_and_accept()
						end
					end,
					"snippet_forward",
					"fallback",
				},
				["<S-Tab>"] = { "snippet_backward", "fallback" },

				["<Up>"] = { "select_prev", "fallback" },
				["<Down>"] = { "select_next", "fallback" },
				["<C-p>"] = { "select_prev", "fallback_to_mappings" },
				["<C-n>"] = { "select_next", "fallback_to_mappings" },

				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },

				["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
			},

			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
			},

			-- (Default) Only show the documentation popup when manually triggered
			completion = { documentation = { auto_show = false } },

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},

			-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
			-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
			-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
			--
			-- See the fuzzy documentation for more information
			-- fuzzy = { implementation = "prefer_rust_with_warning" },
			fuzzy = { implementation = "lua" },
		},
		opts_extend = { "sources.default" },
	},

	-- autocomplete
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
	-- 		local lspkind = require("lspkind")
	--
	-- 		require("luasnip.loaders.from_vscode").lazy_load()
	-- 		require("luasnip").filetype_extend("typescript", { "tsdoc" })
	-- 		require("luasnip").filetype_extend("javascript", { "jsdoc" })
	-- 		require("luasnip").filetype_extend("lua", { "luadoc" })
	-- 		require("luasnip").filetype_extend("python", { "pydoc" })
	-- 		require("luasnip").filetype_extend("rust", { "rustdoc" })
	--
	-- 		vim.o.completeopt = "menu,menuone,noinsert,noselect"
	-- 		-- return {
	-- 		cmp.setup({
	-- 			-- window = {
	-- 			-- 	documentation = true,
	-- 			-- },
	-- 			-- sorting = {
	-- 			-- 	priority_weight = 2,
	-- 			-- 	comparators = {
	-- 			-- 		function(entry1, entry2)
	-- 			-- 			local kind1 = entry1:get_kind()
	-- 			-- 			local kind2 = entry2:get_kind()
	-- 			-- 			local method_priority = {
	-- 			-- 				[cmp.lsp.CompletionItemKind.Method] = 1,
	-- 			-- 				[cmp.lsp.CompletionItemKind.Function] = 2,
	-- 			-- 				[cmp.lsp.CompletionItemKind.Constructor] = 3,
	-- 			-- 			}
	-- 			-- 			local priority1 = method_priority[kind1] or 100
	-- 			-- 			local priority2 = method_priority[kind2] or 100
	-- 			-- 			if priority1 ~= priority2 then
	-- 			-- 				return priority1 < priority2
	-- 			-- 			end
	-- 			-- 		end,
	-- 			-- 		cmp.config.compare.offset,
	-- 			-- 		cmp.config.compare.exact,
	-- 			-- 		cmp.config.compare.score,
	-- 			-- 		cmp.config.compare.recently_used,
	-- 			-- 		cmp.config.compare.kind,
	-- 			-- 		cmp.config.compare.sort_text,
	-- 			-- 		cmp.config.compare.length,
	-- 			-- 		cmp.config.compare.order,
	-- 			-- 	},
	-- 			-- },
	-- 			formatting = {
	-- 				format = lspkind.cmp_format({
	-- 					-- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
	-- 					mode = "symbol_text",
	-- 					maxwidth = {
	-- 						menu = 50, -- leading text (labelDetails)
	-- 						abbr = 50, -- actual suggestion item
	-- 					},
	-- 					ellipsis_char = "...",
	-- 					show_labelDetails = true,
	-- 					before = function(entry, vim_item)
	-- 						return vim_item
	-- 					end,
	-- 				}),
	-- 			},
	-- 			snippet = {
	-- 				-- REQUIRED by nvim-cmp. get rid of it once we can
	-- 				expand = function(args)
	-- 					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
	-- 				end,
	-- 			},
	-- 			mapping = cmp.mapping.preset.insert({
	-- 				["<C-b>"] = cmp.mapping.scroll_docs(-4),
	-- 				["<C-f>"] = cmp.mapping.scroll_docs(4),
	-- 				["<C-m>"] = cmp.mapping.complete(),
	-- 				["<C-e>"] = cmp.mapping.abort(),
	-- 				-- Accept currently selected item.
	-- 				-- Set `select` to `false` to only confirm explicitly selected items.
	-- 				["<CR>"] = cmp.mapping.confirm({
	-- 					select = true,
	-- 				}),
	--
	-- 				["<Tab>"] = cmp.mapping(function(fallback)
	-- 					if cmp.visible() then
	-- 						cmp.select_next_item()
	-- 					elseif luasnip.expand_or_jumpable() then
	-- 						luasnip.expand_or_jump()
	-- 					else
	-- 						-- If in insert mode and the cursor is
	-- 						-- at the beginning of the line
	-- 						-- or before a whitespace character, insert a tab
	-- 						local col = vim.fn.col(".") - 1
	-- 						if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
	-- 							vim.api.nvim_feedkeys(
	-- 								vim.api.nvim_replace_termcodes("<Tab>", true, true, true),
	-- 								"n",
	-- 								true
	-- 							)
	-- 						else
	-- 							fallback() -- Pass through if no action is possible
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
	-- 						fallback() -- Pass through if no action is possible
	-- 					end
	-- 				end, { "i", "s" }),
	-- 			}),
	-- 			sources = cmp.config.sources({
	-- 				{ name = "nvim_lsp" },
	-- 				{ name = "luasnip" },
	-- 				{ name = "path" },
	-- 				-- { name = "conjure" },
	-- 			}, {
	-- 				{ name = "buffer" },
	-- 			}),
	-- 		})
	-- 	end,
	-- },
	{
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		config = function()
			require("crates").setup()
		end,
	},
}
