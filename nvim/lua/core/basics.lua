vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

-- Yank (copy) to system cilpboard
vim.opt.clipboard:append { 'unnamed', 'unnamedplus' }

-- keep 8 lines while scroll up and down
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

vim.g.python3_host_prog = "~/.pyenv/versions/3.10.5/bin/python3.10"
