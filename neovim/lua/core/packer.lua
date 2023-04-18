-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Telescope
    use { 'nvim-telescope/telescope.nvim', tag = '0.1.1', requires = { { 'nvim-lua/plenary.nvim' } } }

    -- Colorscheme
    use 'ellisonleao/gruvbox.nvim'

    -- Treesitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    -- LSP Support
    use {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
        'simrat39/rust-tools.nvim',
        'onsails/lspkind.nvim',
        'jose-elias-alvarez/null-ls.nvim', -- for formatters and linters
    }

    -- Debugging
    use {
        'nvim-lua/plenary.nvim',
        'mfussenegger/nvim-dap',
    }

    -- Autocompletion
    use {
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'saadparwaiz1/cmp_luasnip',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua'
    }

    -- Snippets
    use {
        'L3MON4D3/LuaSnip',
        'rafamadriz/friendly-snippets'
    }

    -- Editing Support
    use {
        'windwp/nvim-autopairs',
        'numToStr/Comment.nvim',
    }
end)
