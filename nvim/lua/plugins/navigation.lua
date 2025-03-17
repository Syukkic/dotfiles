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
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
			"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
		},
		init = function()
			vim.g.barbar_auto_setup = true
			local map = vim.api.nvim_set_keymap
			local opts = { noremap = true, silent = true }
			filetype =
				{
					-- Sets the icon's highlight group.
					-- If false, will use nvim-web-devicons colors
					custom_colors = true,

					-- Requires `nvim-web-devicons` if `true`
					enabled = true,
				},
				-- Move to previous/next
				map("n", "<C-,>", "<Cmd>BufferPrevious<CR>", opts)
			map("n", "<C-.>", "<Cmd>BufferNext<CR>", opts)

			-- Re-order to previous/next
			map("n", "<C-<>", "<Cmd>BufferMovePrevious<CR>", opts)
			map("n", "<C->>", "<Cmd>BufferMoveNext<CR>", opts)

			-- Goto buffer in position...
			map("n", "<leader>1", "<Cmd>BufferGoto 1<CR>", opts)
			map("n", "<leader>2", "<Cmd>BufferGoto 2<CR>", opts)
			map("n", "<leader>3", "<Cmd>BufferGoto 3<CR>", opts)
			map("n", "<leader>4", "<Cmd>BufferGoto 4<CR>", opts)
			map("n", "<leader>5", "<Cmd>BufferGoto 5<CR>", opts)
			map("n", "<leader>6", "<Cmd>BufferGoto 6<CR>", opts)
			map("n", "<leader>7", "<Cmd>BufferGoto 7<CR>", opts)
			map("n", "<leader>8", "<Cmd>BufferGoto 8<CR>", opts)
			map("n", "<leader>9", "<Cmd>BufferGoto 9<CR>", opts)
			map("n", "<leader>0", "<Cmd>BufferLast<CR>", opts)

			-- Close buffer
			map("n", "<A-c>", "<Cmd>BufferClose<CR>", opts)
		end,
		version = "^1.0.0", -- optional: only update when a new 1.x version is released
	},
}
