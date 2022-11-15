local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

return require("packer").startup(function(use)
    use "wbthomason/packer.nvim"
    use "williamboman/mason.nvim"
    use "williamboman/mason-lspconfig.nvim"
    use "neovim/nvim-lspconfig"
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-nvim-lsp"
    use "onsails/lspkind.nvim"

    use "nvim-tree/nvim-tree.lua"
    use "lukas-reineke/indent-blankline.nvim"

    use {'akinsho/bufferline.nvim', tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons'}
    use {'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true }}

    use { "ellisonleao/gruvbox.nvim" }
end
)
