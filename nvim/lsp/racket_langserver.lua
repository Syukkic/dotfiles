vim.lsp.config('racket_langserver', {
  -- https://www.andersevenrud.net/neovim.github.io/lsp/configurations/racket_langserver/
  cmd = { 'racket', '--lib', 'racket-langserver' },
  filetypes = { 'racket', 'scheme' },
})
