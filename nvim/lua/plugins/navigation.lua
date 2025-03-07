return {
	-- Fuzz Finder
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		version = false,
		keys = {
			{ "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Telescope find files" },
			{ "<C-g>", "<cmd>Telescope live_grep<cr>", desc = "Telescope live grep" },
			{ "<C-b>", "<cmd>Telescope buffers<cr>", desc = "Telescope buffers" },
			{ "<C-h>", "<cmd>Telescope help_tags<cr>", desc = "Telescope help tags" },
		},
		opts = {
			defaults = {
				layout_strategy = "horizontal",
				layout_config = { prompt_position = "bottom" },
				sorting_strategy = "descending",
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			ensure_installed = {
				"bash",
				"beancount",
				"fish",
				"haskell",
				"html",
				"javascript",
				"lua",
				"markdown",
				"python",
				"rust",
				"svelte",
				"sql",
				"tsx",
				"typescript",
				"vim",
			},
			highlight = { enable = true },
			indent = { enable = true },
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
