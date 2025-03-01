require("bootstrap")
require("config.options")

require("lazy").setup({
	spec = {
		{ import = "plugins.ui" },
		{ import = "plugins.navigation" },
		{ import = "plugins.coding" },
		{ import = "plugins.utils" },
	},
	defaults = {
		lazy = false,
		version = false,
	},
	checker = { enabled = false },
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				-- "netrwPlugin",
				"tarPlugin",
				"tohtml",
				"zipPlugin",
			},
		},
	},
})

require("config.keymaps")
require("config.autocmds")
