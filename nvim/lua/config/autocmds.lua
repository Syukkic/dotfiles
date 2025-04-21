-- highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  command = 'silent! lua vim.highlight.on_yank({ timeout = 500 })',
})

-- jump to last edit position on opening file
vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '*',
  callback = function()
    if vim.fn.line '\'"' > 1 and vim.fn.line '\'"' <= vim.fn.line '$' then
      -- except for in git commit messages
      -- https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
      if not vim.fn.expand('%:p'):find('.git', 1, true) then
        vim.cmd 'exe "normal! g\'\\""'
      end
    end
  end,
})

-- prevent accidental writes to buffers that shouldn't be edited
vim.api.nvim_create_autocmd('BufRead', {
  pattern = '*.orig',
  command = 'set readonly',
})

vim.api.nvim_create_autocmd('BufRead', {
  pattern = '*.pacnew',
  command = 'set readonly',
})

-- leave paste mode when leaving insert mode (if it was on)
vim.api.nvim_create_autocmd('InsertLeave', {
  pattern = '*',
  command = 'set nopaste',
})

-- help filetype detection (add as needed)
-- vim.api.nvim_create_autocmd('BufRead', { pattern = '*.ext', command = 'set filetype=someft' })
-- correctly classify mutt buffers
local email = vim.api.nvim_create_augroup('email', { clear = true })
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '/tmp/mutt*',
  group = email,
  command = 'setfiletype mail',
})

-- https://brianbuccola.com/line-breaks-in-mutt-and-vim/
vim.api.nvim_create_autocmd('Filetype', {
  pattern = 'mail',
  group = email,
  command = 'setlocal formatoptions+=w',
})

-- shorter columns in text because it reads better that way
local text = vim.api.nvim_create_augroup('text', { clear = true })
for _, pat in ipairs { 'text', 'markdown', 'mail', 'gitcommit' } do
  vim.api.nvim_create_autocmd('Filetype', {
    pattern = pat,
    group = text,
    command = 'setlocal spell tw=72 colorcolumn=73',
  })
end

--- TeX has so much syntax that a little wider is ok
vim.api.nvim_create_autocmd('Filetype', {
  pattern = 'tex',
  group = text,
  command = 'setlocal spell tw=80 colorcolumn=81',
})

--- Disable Relative Numbers in Insert Mode
vim.api.nvim_create_autocmd('InsertEnter', {
  callback = function()
    vim.opt.relativenumber = false
    vim.opt.number = true
  end,
})

--- Enable Relative Numbers in Insert Mode
vim.api.nvim_create_autocmd('InsertLeave', {
  callback = function()
    vim.opt.relativenumber = true
  end,
})

--- Disable Auto-Comment on New Line
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  command = 'set formatoptions-=cro',
})

-- Trigger when a new Python file is created (BufNewFile)
-- or a Python file is saved (BufWritePost)
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufWritePost' }, {
  pattern = '*.py',
  callback = function()
    local clients = vim.lsp.get_clients()
    for _, client in ipairs(clients) do
      if client.name == 'pyright' then
        client.notify('workspace/didChangeWatchedFiles', {
          changes = { { uri = vim.uri_from_fname(vim.fn.expand '%:p'), type = 1 } },
        })
      end
    end
  end,
})

-- vim.api.nvim_create_autocmd("CursorMoved", {
-- 	-- https://stackoverflow.com/a/14957727
-- 	pattern = "*",
-- 	callback = function()
-- 		local current_line = vim.fn.line(".") -- current cursor
-- 		local last_line = vim.fn.line("$") -- last line of file
--
-- 		if current_line == last_line then
-- 			vim.fn.append(last_line, "") -- insert empty line at the bottom
-- 		end
-- 	end,
-- })

-- [[

-- -- Being replaced by conform.nvim
-- -- Remove Trailing Whitespace on Save
-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	pattern = "*",
-- 	command = [[%s/\s\+$//e]],
-- })

--]]
