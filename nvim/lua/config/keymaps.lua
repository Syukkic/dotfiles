-- search buffers
vim.keymap.set("n", "<leader>;", "<cmd>Buffers<cr>")
-- quick-save
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>")
vim.keymap.set("n", "<C-s>", "<cmd>w<cr>")
-- vim.keymap.set("n", "<C-S>", "<cmd>w<cr>")
-- make missing : less annoying
vim.keymap.set("n", ";", ":")
-- Ctrl+h to stop searching
vim.keymap.set("v", "<leader>Q", "<cmd>nohlsearch<cr>")
vim.keymap.set("n", "<leader>Q", "<cmd>nohlsearch<cr>")
-- Jump to start and end of line using the home row keys
vim.keymap.set("", "H", "^")
vim.keymap.set("", "L", "$")

-- delete current buffer
vim.keymap.set("n", "<leader>bd", "<cmd>bd<cr>")

-- <leader>p will paste clipboard into buffer
-- <leader>c will copy entire buffer into clipboard
vim.keymap.set("n", "<leader>p", "<cmd>read !wl-paste<cr>")
vim.keymap.set("n", "<leader>c", "<cmd>w !wl-copy<cr><cr>")
-- Yank selection to system clipboard in visual mode
vim.keymap.set("v", "<leader>y", '"+y', { noremap = true, silent = true })
-- Explore
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
-- <leader><leader> toggles between buffers
vim.keymap.set("n", "<leader><leader>", "<c-^>")
-- <leader>, shows/hides hidden characters
vim.keymap.set("n", "<leader>,", ":set invlist<cr>")
-- always center search results
vim.keymap.set("n", "n", "nzz", { silent = true })
vim.keymap.set("n", "N", "Nzz", { silent = true })
vim.keymap.set("n", "*", "*zz", { silent = true })
vim.keymap.set("n", "#", "#zz", { silent = true })
vim.keymap.set("n", "g*", "g*zz", { silent = true })
-- "very magic" (less escaping needed) regexes by default
vim.keymap.set("n", "?", "?\\v")
vim.keymap.set("n", "/", "/\\v")
vim.keymap.set("c", "%s/", "%sm/")
-- open new file adjacent to current file
vim.keymap.set("n", "<leader>o", ':e <C-R>=expand("%:p:h") . "/" <cr>')
-- no arrow keys --- force yourself to use the home row
vim.keymap.set("n", "<up>", "<nop>")
vim.keymap.set("n", "<down>", "<nop>")
vim.keymap.set("i", "<up>", "<nop>")
vim.keymap.set("i", "<down>", "<nop>")
vim.keymap.set("i", "<left>", "<nop>")
vim.keymap.set("i", "<right>", "<nop>")
-- let the left and right arrows be useful: they can switch buffers
vim.keymap.set("n", "<left>", ":bp<cr>")
vim.keymap.set("n", "<right>", ":bn<cr>")
-- make j and k move by visual line, not actual line, when text is soft-wrapped
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
-- F1 is pretty close to Esc, so you probably meant Esc
vim.keymap.set("", "<F1>", "<Esc>")
vim.keymap.set("i", "<F1>", "<Esc>")

-- Move line(s) up or down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
