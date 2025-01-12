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
			-- XXX
			-- Would be nice to customize the highlighting of warnings and the like to make
			-- them less glaring. But alas
			-- https://github.com/nvim-lua/lsp_extensions.nvim/issues/21
			-- call Base16hi("CocHintSign", g:base16_gui03, "", g:base16_cterm03, "", "", "")
		end,
	}, -- nice bar at the bottom
	{
		"itchyny/lightline.vim",
		lazy = false, -- also load at start since it's UI
		config = function()
			-- no need to also show mode in cmd line when we have bar
			vim.o.showmode = false
			vim.g.lightline = {
				colorscheme = "wombat",
				active = {
					left = { { "mode", "paste" }, { "readonly", "filename", "modified" } },
					right = { { "lineinfo" }, { "percent" }, { "fileencoding", "filetype" } },
				},
				component_function = {
					filename = "LightlineFilename",
				},
			}
			function LightlineFilenameInLua(opts)
				if vim.fn.expand("%:t") == "" then
					return "[No Name]"
				else
					return vim.fn.getreg("%")
				end
			end
			-- https://github.com/itchyny/lightline.vim/issues/657
			vim.api.nvim_exec(
				[[
				function! g:LightlineFilename()
					return v:lua.LightlineFilenameInLua()
				endfunction
				]],
				true
			)
		end,
	}, -- quick navigation
	{
		"ggandor/leap.nvim",
		config = function()
			require("leap").create_default_mappings()
		end,
	}, -- better %
	{
		"andymass/vim-matchup",
		config = function()
			vim.g.matchup_matchparen_offscreen = {
				method = "popup",
			}
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
	}, -- language support
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
					typescript = { "prettier" },
					javascriptreact = { "prettier" },
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
			vim.keymap.set({ "n", "v" }, "<leader>mp", function()
				conform.format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 500,
				})
			end, { desc = "Format file or range (in visual mode)" })
		end,
	},
}
