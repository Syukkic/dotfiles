-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local opts = { noremap = true, silent = true }

-- Diagnostics
vim.keymap.set("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end, opts)
