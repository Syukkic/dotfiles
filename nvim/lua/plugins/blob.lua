return {
	{
		"Syukkic/base16-nvim",
		lazy = false, -- load at start
		priority = 1000, -- load first
		config = function()
			vim.o.background = "dark"
			vim.cmd([[colorscheme base16-gruvbox-dark-hard]])
			-- require("base16-colorscheme").setup({
			-- 	base00 = "#f8f8f8",
			-- 	base01 = "#e5e5e5",
			-- 	base02 = "#b9dcdd",
			-- 	base03 = "#a5a5a5",
			-- 	base04 = "#555555",
			-- 	base05 = "#000f7f",
			-- 	base06 = "#323232",
			-- 	base07 = "#000000",
			-- 	base08 = "#257e99",
			-- 	base09 = "#007d00",
			-- 	base0A = "#af4444",
			-- 	base0B = "#a3182b",
			-- 	base0C = "#0598bc",
			-- 	base0D = "#785d25",
			-- 	base0E = "#0000ff",
			-- 	base0F = "#424442",
			-- })
			-- XXX: hi Normal ctermbg=NONE
			-- Make comments more prominent -- they are important.
			local bools = vim.api.nvim_get_hl(0, {
				name = "Boolean",
			})
			vim.api.nvim_set_hl(0, "Comment", bools)
			-- Make it clearly visible which argument we're at.
			local marked = vim.api.nvim_get_hl(0, {
				name = "PMenu",
			})
			vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", {
				fg = marked.fg,
				bg = marked.bg,
				ctermfg = marked.ctermfg,
				ctermbg = marked.ctermbg,
				bold = true,
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },

		config = function()
			require("lualine").setup({
				options = { theme = "gruvbox" },
				-- options = { theme = "onelight" },
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"c",
					"lua",
					"vim",
					"vimdoc",
					"python",
					"markdown",
					"markdown_inline",
					"scheme",
				},
				highlight = { enable = true },
			})
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		-- config = true,
		-- use opts = {} for passing setup options
		-- this is equivalent to setup({}) function
		config = function()
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			require("nvim-autopairs").setup({
				cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done()),
			})
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("", "<C-p>", builtin.find_files, { desc = "Telescope find files" })
			vim.keymap.set("", "<C-g>", builtin.live_grep, { desc = "Telescope live grep" })
			vim.keymap.set("", "<C-b>", builtin.buffers, { desc = "Telescope buffers" })
			vim.keymap.set("", "<C-t>", builtin.help_tags, { desc = "Telescope help tags" })
		end,
	},
	-- inline function signatures
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {},
		config = function(_, opts)
			-- Get signatures (and _only_ signatures) when in argument lists.
			require("lsp_signature").setup({
				doc_lines = 0,
				handler_opts = {
					border = "none",
				},
			})
		end,
	},
	-- language support
	-- toml
	"cespare/vim-toml",
	-- yaml
	{
		"cuducos/yaml.nvim",
		ft = { "yaml" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
	"khaveesh/vim-fish-syntax",
	-- markdown
	{
		"plasticboy/vim-markdown",
		ft = { "markdown" },
		dependencies = { "godlygeek/tabular" },
		config = function()
			-- never ever fold!
			vim.g.vim_markdown_folding_disabled = 1
			-- support front-matter in .md files
			vim.g.vim_markdown_frontmatter = 1
			-- 'o' on a list item should insert at same level
			vim.g.vim_markdown_new_list_item_indent = 0
			-- don't add bullets when wrapping:
			-- https://github.com/preservim/vim-markdown/issues/232
			vim.g.vim_markdown_auto_insert_bullets = 0
		end,
	},
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
					javascript = { "prettier" },
					javascriptreact = { "prettier" },
					typescript = { "prettier" },
					typescriptreact = { "prettier" },
					svelte = { "prettier" },
					css = { "prettier" },
					html = { "prettier" },
					json = { "prettier" },
					yaml = { "prettier" },
					markdown = { "prettier" },
					graphql = { "prettier" },
					lua = { "stylua" },
					python = { "isort", "ruff" },
				},
				format_on_save = {
					lsp_fallback = true,
					async = false,
					timeout_ms = 500,
				},
			})

			conform.formatters.prettier = {
				prepend_args = { "--single-quote", "true" },
			}
			vim.keymap.set({ "n", "v" }, "<leader>mp", function()
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 500,
				})
			end, { desc = "Format file or range (in visual mode)" })
		end,
	},
	{
		"laytan/cloak.nvim",
		config = function()
			require("cloak").setup({
				enabled = true,
				cloak_character = "*",
				-- The applied highlight group (colors) on the cloaking, see `:h highlight`.
				highlight_group = "Comment",
				-- Applies the length of the replacement characters for all matched
				-- patterns, defaults to the length of the matched pattern.
				cloak_length = nil, -- Provide a number if you want to hide the true length of the value.
				-- Whether it should try every pattern to find the best fit or stop after the first.
				try_all_patterns = true,
				-- Set to true to cloak Telescope preview buffers. (Required feature not in 0.1.x)
				cloak_telescope = true,
				-- Re-enable cloak when a matched buffer leaves the window.
				cloak_on_leave = false,
				patterns = {
					{
						-- Match any file starting with '.env'.
						-- This can be a table to match multiple file patterns.
						file_pattern = ".env*",
						-- Match an equals sign and any character after it.
						-- This can also be a table of patterns to cloak,
						-- example: cloak_pattern = { ':.+', '-.+' } for yaml files.
						cloak_pattern = "=.+",
						-- A function, table or string to generate the replacement.
						-- The actual replacement will contain the 'cloak_character'
						-- where it doesn't cover the original text.
						-- If left empty the legacy behavior of keeping the first character is retained.
						replace = nil,
					},
				},
			})
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load() -- Load friendly-snippets
		end,
	},
	{
		"andymass/vim-matchup",
		config = function()
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end,
	},
}
