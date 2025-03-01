return {
	-- {
	-- 	"ellisonleao/gruvbox.nvim",
	-- 	config = function()
	-- 		require("gruvbox").setup({
	-- 			terminal_colors = true, -- add neovim terminal colors
	-- 			undercurl = true,
	-- 			underline = true,
	-- 			bold = true,
	-- 			italic = {
	-- 				strings = false,
	-- 				emphasis = false,
	-- 				comments = true,
	-- 				operators = false,
	-- 				folds = true,
	-- 			},
	-- 			strikethrough = true,
	-- 			invert_selection = false,
	-- 			invert_signs = false,
	-- 			invert_tabline = false,
	-- 			invert_intend_guides = false,
	-- 			inverse = true, -- invert background for search, diffs, statuslines and errors
	-- 			contrast = "", -- can be "hard", "soft" or empty string
	-- 			palette_overrides = {},
	-- 			overrides = {},
	-- 			dim_inactive = false,
	-- 			transparent_mode = false,
	-- 		})
	-- 		vim.o.background = "dark"
	-- 		vim.cmd("colorscheme gruvbox")
	-- 	end,
	-- },
	{
		"Mofiqul/vscode.nvim",
		config = function()
			vim.o.background = "light"
			require("vscode").setup({
				style = "light",
				italic_comments = true,
			})
			vim.cmd.colorscheme("vscode")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },

		config = function()
			require("lualine").setup({
				options = { theme = "vscode" },
			})
		end,
	},
}
