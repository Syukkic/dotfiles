return {
	'neovim/nvim-lspconfig',
	dependencies = { 'saghen/blink.cmp' },

	-- example using `opts` for defining servers
	opts = {
		servers = {
			lua_ls = {
				settings = {
					Lua = {
						diagnostics = {
							globals = { 'vim', 'luasnip' },
						},
						runtime = {
							version = 'LuaJIT',
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file('', true),
						},
						telemetry = {
							enable = false,
						},
						hint = {
							enable = true,
							setType = false,
							paramType = true,
							paramName = 'Disable',
							semicolon = 'Disable',
							arrayIndex = 'Disable',
						},
					},
				},
			},
		},
		pyright = {
			filetypes = { 'python' },
			settings = {
				python = {
					analysis = {
						typeCheckingMode = 'basic',     -- "off", "basic", or "strict"
						autoSearchPaths = true,
						useLibraryCodeForTypes = true,
						reportMissingImports = true,
						reportUnusedImport = true,
						reportUndefinedVariable = true,
						stubPath = 'typings',
					},
				},
			},
		},
	},
	config = function(_, opts)
		local lspconfig = require('lspconfig')
		for server, config in pairs(opts.servers) do
			config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
			lspconfig[server].setup(config)
		end
		vim.keymap.set('n', '<leader>l', '<cmd>Outline<CR>', {
			desc = 'Toggle Outline',
		})
		vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
		vim.keymap.set('n', '[d', function()
			vim.diagnostic.jump({
				count = -1,
				float = true,
			})
		end)
		vim.keymap.set('n', ']d', function()
			vim.diagnostic.jump({
				count = 1,
				float = true,
			})
		end)
		vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
		-- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
		vim.keymap.set('n', 'gD', '<cmd>Telescope lsp_references<CR>', { noremap = true, silent = true })
		-- vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
		vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', { noremap = true, silent = true })
		vim.keymap.set('n', 'K', vim.lsp.buf.hover)
		-- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
		vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', { noremap = true, silent = true })
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help)
		vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder)
		vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder)
		vim.keymap.set('n', '<leader>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end)
		vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename)
		vim.keymap.set({ 'n', 'v' }, '<leader>a', vim.lsp.buf.code_action)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references)
		vim.keymap.set('n', '<leader>f', function()
			vim.lsp.buf.format({
				async = true,
			})
		end)
		vim.keymap.set('n', '<leader>i', function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 })
		end)
	end
	--     local lspconfig = require('lspconfig')
	--     local capabilities = require('blink.cmp').get_lsp_capabilities()
	--     local function on_attach()
	--       if vim.lsp.inlay_hint then
	--         vim.lsp.inlay_hint.enable(true, { 0 })
	--       end
	--     end
	--     for server, config in pairs(opts.servers) do
	--       -- lspconfig[server].setup(vim.tbl_deep_extend('force', {
	--       lspconfig[server].setup({
	--         capabilities = capabilities,
	--         on_attach = on_attach,
	--       }, config)
	--     end
	--     vim.keymap.set('n', '<leader>l', '<cmd>Outline<CR>', {
	--       desc = 'Toggle Outline',
	--     })
	--     vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
	--     vim.keymap.set('n', '[d', function()
	--       vim.diagnostic.jump({
	--         count = -1,
	--         float = true,
	--       })
	--     end)
	--     vim.keymap.set('n', ']d', function()
	--       vim.diagnostic.jump({
	--         count = 1,
	--         float = true,
	--       })
	--     end)
	--     vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)
	--     -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
	--     vim.keymap.set('n', 'gD', '<cmd>Telescope lsp_references<CR>', { noremap = true, silent = true })
	--     -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
	--     vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', { noremap = true, silent = true })
	--     vim.keymap.set('n', 'K', vim.lsp.buf.hover)
	--     -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
	--     vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', { noremap = true, silent = true })
	--     vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help)
	--     vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder)
	--     vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder)
	--     vim.keymap.set('n', '<leader>wl', function()
	--       print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	--     end)
	--     vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename)
	--     vim.keymap.set({ 'n', 'v' }, '<leader>a', vim.lsp.buf.code_action)
	--     vim.keymap.set('n', 'gr', vim.lsp.buf.references)
	--     vim.keymap.set('n', '<leader>f', function()
	--       vim.lsp.buf.format({
	--         async = true,
	--       })
	--     end)
	--     vim.keymap.set('n', '<leader>i', function()
	--       vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 })
	--     end)
	--   end,
	-- },
}
