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
    ensure_installed = { "lua_ls", "gopls", "pyright", "rust_analyzer" }
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

    -- buf_set_keymap("n", "gd", ":lua vim.lsp.buf.definition()<CR>", opts) --> jumps to the definition of the symbol under the cursor
	-- buf_set_keymap("n", "<leader>lh", ":lua vim.lsp.buf.hover()<CR>", opts) --> information about the symbol under the cursos in a floating window
	-- buf_set_keymap("n", "gi", ":lua vim.lsp.buf.implementation()<CR>", opts) --> lists all the implementations for the symbol under the cursor in the quickfix window
	-- buf_set_keymap("n", "<leader>rn", ":lua vim.lsp.util.rename()<CR>", opts) --> renaname old_fname to new_fname
	-- buf_set_keymap("n", "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>", opts) --> selects a code action available at the current cursor position
	-- buf_set_keymap("n", "gr", ":lua vim.lsp.buf.references()<CR>", opts) --> lists all the references to the symbl under the cursor in the quickfix window
	-- buf_set_keymap("n", "<leader>ld", ":lua vim.diagnostic.open_float()<CR>", opts)
	-- buf_set_keymap("n", "[d", ":lua vim.diagnostic.goto_prev()<CR>", opts)
	-- buf_set_keymap("n", "]d", ":lua vim.diagnostic.goto_next()<CR>", opts)
	-- buf_set_keymap("n", "<leader>lq", ":lua vim.diagnostic.setloclist()<CR>", opts)
	-- buf_set_keymap("n", "<leader>lf", ":lua vim.lsp.buf.formatting()<CR>", opts) --> formats the current buffer

    buf_set_keymap('n', 'gD', ":lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap('n', 'gd', ":lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap('n', 'K', ":lua vim.lsp.buf.hover()<CR>", opts)
    -- buf_set_keymap('n', 'gi', vim.lsp.buf.implementation, opts)
    -- buf_set_keymap('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    buf_set_keymap('n', '<leader>wa', ":lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    buf_set_keymap('n', '<leader>wr', ":lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    buf_set_keymap('n', '<leader>D', ":lua vim.lsp.buf.type_definition()<CR>", opts)
    buf_set_keymap('n', '<leader>rn', ":lua vim.lsp.buf.rename()<CR>", opts)
    -- buf_set_keymap({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    -- buf_set_keymap('n', 'gr', vim.lsp.buf.references, opts)
    -- buf_set_keymap('n', '<space>f', function() vim.lsp.buf.format { async = true }end, opts)

end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local nvim_lsp = require("lspconfig")
local servers = {"lua_ls", "pyright", "gopls", "rust_analyzer"}

for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        capabilities = capabilities,
        on_attach = on_attach,
    }

end


-- local rt = require("rust-tools")

-- rt.setup({
--   server = {
--     on_attach = function(_, bufnr)
--       -- Hover actions
--       vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
--       -- Code action groups
--       vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
--     end,
--   },
-- })

-- nvim-cmp
local cmp = require('cmp')
local lspkind = require('lspkind')
local luasnip = require('luasnip')

-- better autocompletion experience
vim.o.completeopt = 'menuone,noselect'

cmp.setup {
	-- Format the autocomplete menu
	formatting = {
		format = lspkind.cmp_format()
	},
	mapping = {
        -- Use Tab and shift-Tab to navigate autocomplete menu
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
        end,
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
}
