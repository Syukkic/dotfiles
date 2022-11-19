local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

return require("packer").startup(function(use)
    -- Plugin Manager
    use "wbthomason/packer.nvim"

    -- LSP
    use "williamboman/mason.nvim"
    use "williamboman/mason-lspconfig.nvim"
    use "neovim/nvim-lspconfig"
    use "RRethy/vim-illuminate"
    use "onsails/lspkind.nvim"
    use({ "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" })

    -- Completion
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-nvim-lua"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "saadparwaiz1/cmp_luasnip"

    -- Snippet
    use "L3MON4D3/LuaSnip" --snippet engine
    use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

    -- Fuzzy Finder / Telescope
    use "nvim-telescope/telescope.nvim"
    use "nvim-telescope/telescope-media-files.nvim"
    use "tom-anders/telescope-vim-bookmarks.nvim"
    
    -- Syntax/Treesitter
    use "nvim-treesitter/nvim-treesitter"

    -- File Explorer
    use "nvim-tree/nvim-tree.lua"

    -- Indent
    use "lukas-reineke/indent-blankline.nvim"

    -- Comment
    use "numToStr/Comment.nvim"

    use "liuchengxu/vista.vim"

    use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}
    use {'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true}}

    -- Editing Support
    use "windwp/nvim-autopairs"

    -- Icon
    use "kyazdani42/nvim-web-devicons"

    -- Colorscheme
    use { "ellisonleao/gruvbox.nvim" }
end
)

