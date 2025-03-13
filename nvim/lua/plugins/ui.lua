return {
	{
		"ellisonleao/gruvbox.nvim",
		config = function()
			require("gruvbox").setup({
				terminal_colors = true, -- add neovim terminal colors
				undercurl = true,
				underline = true,
				bold = true,
				italic = {
					strings = false,
					emphasis = false,
					comments = true,
					operators = false,
					folds = true,
				},
				strikethrough = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				invert_intend_guides = false,
				inverse = true, -- invert background for search, diffs, statuslines and errors
				contrast = "", -- can be "hard", "soft" or empty string
				palette_overrides = {},
				overrides = {},
				dim_inactive = false,
				transparent_mode = false,
			})
			vim.o.background = "dark"
			vim.cmd("colorscheme gruvbox")
		end,
	},
	-- {
	-- 	"RRethy/base16-nvim",
	-- 	lazy = false, -- load at start
	-- 	priority = 1000, -- load first
	-- 	config = function()
	-- 		vim.o.background = "light"
	-- 		-- vim.cmd([[colorscheme base16-gruvbox-dark-hard]])
	-- 		require("base16-colorscheme").setup({
	-- 			base00 = "#f8f8f8",
	-- 			base01 = "#e5e5e5",
	-- 			base02 = "#b9dcdd",
	-- 			base03 = "#a5a5a5",
	-- 			base04 = "#555555",
	-- 			base05 = "#000f7f",
	-- 			base06 = "#323232",
	-- 			base07 = "#000000",
	-- 			base08 = "#257e99",
	-- 			base09 = "#007d00",
	-- 			base0A = "#af4444",
	-- 			base0B = "#a3182b",
	-- 			base0C = "#0598bc",
	-- 			base0D = "#785d25",
	-- 			base0E = "#0000ff",
	-- 			base0F = "#424442",
	-- 		})
	-- 		-- XXX: hi Normal ctermbg=NONE
	-- 		-- Make comments more prominent -- they are important.
	-- 		local bools = vim.api.nvim_get_hl(0, {
	-- 			name = "Boolean",
	-- 		})
	-- 		vim.api.nvim_set_hl(0, "Comment", bools)
	-- 		-- Make it clearly visible which argument we're at.
	-- 		local marked = vim.api.nvim_get_hl(0, {
	-- 			name = "PMenu",
	-- 		})
	-- 		vim.api.nvim_set_hl(0, "LspSignatureActiveParameter", {
	-- 			fg = marked.fg,
	-- 			bg = marked.bg,
	-- 			ctermfg = marked.ctermfg,
	-- 			ctermbg = marked.ctermbg,
	-- 			bold = true,
	-- 		})
	-- 	end,
	-- },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },

		config = function()
			require("lualine").setup({
				options = { icons_enabled = false },
			})
		end,
	},
}
