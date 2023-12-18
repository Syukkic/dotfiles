local lspconfig = require("lspconfig")
local lspname = "beancount"
local install_path = vim.fn.stdpath("data") .. "/lspinstall/" .. lspname

lspconfig[lspname].setup({
  init_options = {
    journalFile = "~/Repos/beancount/main.bean",
  },
  flags = {
    -- time in millisec to debounce dichange notifications
    debounce_text_changes = 500,
  },
})
