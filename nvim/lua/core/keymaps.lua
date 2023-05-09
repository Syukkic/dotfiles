vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Yank (copy) to system cilpboard
-- vim.opt.clipboard:append { 'unnamed', 'unnamedplus' }
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "<leader>c", ":bw<CR>")

-- nvim-tree
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
vim.keymap.set('n', '<Tab>', '<C-w>w', {noremap = true, silent = true })
