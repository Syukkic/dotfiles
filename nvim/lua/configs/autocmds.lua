-- highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  command = 'silent! lua vim.highlight.on_yank({ timeout = 500 })',
})


-- jump to last edit position on opening file
vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '*',
  callback = function()
    if vim.fn.line('\'"') > 1 and vim.fn.line('\'"') <= vim.fn.line('$') then
      -- except for in git commit messages
      -- https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
      if not vim.fn.expand('%:p'):find('.git', 1, true) then
        vim.cmd('exe "normal! g\'\\""')
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
for _, pat in ipairs({ 'text', 'markdown', 'mail', 'gitcommit' }) do
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
          changes = { { uri = vim.uri_from_fname(vim.fn.expand('%:p')), type = 1 } },
        })
      end
    end
  end,
})

-- https://ww2.coastal.edu/mmurphy2/oer/alpine/neovim/
local function save_as_root(opts)
  local tool = nil

  -- On Alpine Linux, we use doas. However, make this code work on any Linux
  -- distribution by also supporing sudo. Figure out which one we have,
  -- favoring doas if both are installed.
  if vim.system({ 'which', 'doas' }):wait().code == 0 then
    tool = 'doas'
  elseif vim.system({ 'which', 'sudo' }):wait().code == 0 then
    tool = 'sudo'
  end

  -- If neither doas nor sudo are available, return since we can't do anything
  if not tool then
    print('Error: neither doas nor sudo is available')
    return
  end

  local output = ''

  -- We now define a function inside a function (an example of a closure) that lets
  -- us detect if doas/sudo asks for a password. If it asks, we ask the user to
  -- enter their password using vim.fn.inputsecret in order to obscure it. We then
  -- send that password over to doas/sudo to authenticate.
  local function handle_stdout(channel_id, data, name)
    if #data > 0 then
      if data[1]:find('password') then
        local password = vim.fn.inputsecret('(' .. tool .. ') password: ')
        vim.fn.chansend(channel_id, { password, '' })
      else
        output = output .. data[1]:gsub('\r', '\n')
      end
    end
  end

  -- Create a temporary file by getting a temporary filename and writing the contents
  -- of our buffer to it.
  local temp_file = vim.fn.tempname()
  vim.cmd.write(temp_file)

  -- Although we might not use it often, :w supports "save as" functionality by letting
  -- us specify an alternate filename as an argument. We can support the same thing
  -- for :W by picking up the argument.
  local ebang = true
  local filename = vim.api.nvim_buf_get_name(0)
  if opts.args ~= '' then
    ebang = false
    filename = opts.args
  end

  -- Both doas and sudo expect to be running directly in a terminal emulator
  -- (either an actual tty or a pseudoterminal [pty]). Neither command is
  -- happy with basic input redirection, so we have to use the following
  -- construct. What we're doing is using doas/sudo to copy our temporary file
  -- to our original file. We could use the cp command here, but to avoid the
  -- risk of shell differences, we use dd instead.
  local channel_id = vim.fn.jobstart({ tool, 'dd', 'if=' .. temp_file, 'of=' .. filename, 'conv=fsync' }, {
    on_stdout = handle_stdout,
    pty = true,
  })

  if vim.fn.jobwait({ channel_id })[1] == 0 then
    -- Success: reload the buffer and clear the modified flag, unless we saved using an
    -- alternate filename
    if ebang then
      vim.cmd('e!')
    end

    vim.cmd('redraw')
    vim.print('Written (as root): ' .. filename)
  else
    -- Something went wrong, so display the error message in the status line
    vim.print(output)
  end

  -- Clean up the temporary file
  vim.fn.delete(temp_file)
end

vim.api.nvim_create_user_command('W', save_as_root, { desc = 'Save file as root', nargs = '?' })

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
