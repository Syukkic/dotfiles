require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "pyright", "rust_analyzer" }
})


local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
 
    local opts = { noremap = true, silent = true }

    -- keyboard shortcut
    vim.keymap.set('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>')
    vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
    vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
    vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
    vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
    vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
    vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
    vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')

    -- buf_set_keymap('n', 'gD', ":lua vim.lsp.buf.declaration()<CR>", opts)
    -- buf_set_keymap('n', 'gd', ":lua vim.lsp.buf.definition()<CR>", opts)
    -- buf_set_keymap('n', 'K', ":lua vim.lsp.buf.hover()<CR>", opts)
    -- buf_set_keymap('n', 'gi', vim.lsp.buf.implementation, opts)
    -- buf_set_keymap('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    -- buf_set_keymap('n', '<leader>wa', ":lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    -- buf_set_keymap('n', '<leader>wr', ":lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    -- buf_set_keymap('n', '<leader>D', ":lua vim.lsp.buf.type_definition()<CR>", opts)
    -- buf_set_keymap('n', '<leader>rn', ":lua vim.lsp.buf.rename()<CR>", opts)
    -- buf_set_keymap({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    -- buf_set_keymap('n', 'gr', vim.lsp.buf.references, opts)
    -- buf_set_keymap('n', '<space>f', function() vim.lsp.buf.format { async = true }end, opts)

end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local nvim_lsp = require("lspconfig")
local util = require("lspconfig/util")
local servers = {"lua_ls", "pyright", "rust_analyzer", "clangd"}

for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        capabilities = capabilities,
        on_attach = on_attach,
    }
end


