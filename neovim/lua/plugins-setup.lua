local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

return require("packer").startup(function(use)
	-- Plugin Manager
	use("wbthomason/packer.nvim")

	-- Managing & installing lsp server, linter & formatter
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	-- configuring lsp server
	use("neovim/nvim-lspconfig")
	use("hrsh7th/cmp-nvim-lsp")
	use("glepnir/lspsaga.nvim")
	use("ray-x/lsp_signature.nvim")
	use("onsails/lspkind.nvim")
	-- Formatting & linting
	use({ "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" })
	use("jayp0521/mason-null-ls.nvim")

	-- Completion
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")

	-- Snippet
	use("L3MON4D3/LuaSnip") --snippet engine
	use("saadparwaiz1/cmp_luasnip")
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

	-- Fuzzy Finder / Telescope
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-media-files.nvim")
	use("tom-anders/telescope-vim-bookmarks.nvim")

	-- Syntax/Treesitter
	use("nvim-treesitter/nvim-treesitter")

	-- File Explorer
	use("nvim-tree/nvim-tree.lua")

	-- Navigation
	use({ "romgrk/barbar.nvim", wants = "nvim-web-devicons" })

	-- Indent
	use("lukas-reineke/indent-blankline.nvim")

	-- Comment
	use("numToStr/Comment.nvim")

	use("liuchengxu/vista.vim")

	use({ "akinsho/bufferline.nvim", tag = "v3.*", requires = "nvim-tree/nvim-web-devicons" })
	use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons", opt = true } })

	-- Editing Support
	use("windwp/nvim-autopairs")

	-- Icon
	use("kyazdani42/nvim-web-devicons")

	-- Colorscheme
	use({ "ellisonleao/gruvbox.nvim" })
end)
