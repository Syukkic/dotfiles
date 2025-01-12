return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
		-- "mrcjkb/rustaceanvim",
	},

	config = function()
		require("fidget").setup({})
		require("mason").setup({
			ensure_installed = { "lua_ls", "rust_analyzer", "beancount-language-server" },
		})
		require("mason-lspconfig").setup_handlers({
			function(server_name)
				require("lspconfig")[server_name].setup({})
			end,
			["rust_analyzer"] = function()
				require("lspconfig").rust_analyzer.setup({
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
								},
							},
						},
					},
				})
			end,

			["lua_ls"] = function()
				require("lspconfig").lua_ls.setup({
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" }, -- Recognize the `vim` global
							},
						},
					},
				})
			end,
		})

		local cmp = require("cmp")
		cmp.setup({
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
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" }, -- For language server
				{ name = "luasnip" }, -- For luasnip users.
			}, {
				{ name = "path" },
				{ name = "buffer" },
			}),
			vim.diagnostic.config({ virtual_text = true }),
		})

		-- Enable completing paths in :
		cmp.setup.cmdline(":", {
			sources = cmp.config.sources({ {
				name = "path",
			} }),
		})

		-- Global mappings.
		-- See `:help vim.diagnostic.*` for documentation on any of the below functions
		vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
		vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
		-- https://neovim.io/doc/user/lsp.html#LspAttach
		-- Use LspAttach autocommand to only map the following keys
		-- after the language server attaches to the current buffer
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Enable completion triggered by <c-x><c-o>
				vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf }
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
				vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
				vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
				vim.keymap.set("n", "<leader>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, opts)
				vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
				vim.keymap.set({ "n", "v" }, "<leader>a", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "<leader>f", function()
					vim.lsp.buf.format({
						async = true,
					})
				end, opts)

				local client = vim.lsp.get_client_by_id(ev.data.client_id)

				-- When https://neovim.io/doc/user/lsp.html#lsp-inlay_hint stabilizes
				-- *and* there's some way to make it only apply to the current line.
				-- if client.server_capabilities.inlayHintProvider then
				--     vim.lsp.inlay_hint(ev.buf, true)
				-- end

				-- None of this semantics tokens business.
				-- https://www.reddit.com/r/neovim/comments/143efmd/is_it_possible_to_disable_treesitter_completely/
				client.server_capabilities.semanticTokensProvider = nil
			end,
		})
	end,
}
