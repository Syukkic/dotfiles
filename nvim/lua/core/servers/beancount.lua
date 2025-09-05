vim.lsp.config('emmet_language_server', {
  cmd = { 'beancount-language-server', '--stdio' },
  filetypes = { 'bean', 'beancount' },
  init_options = {
    journalFile = '~/personal/finance/main.bean',
    pythonPath = 'python',
  },
  root_dir = function(fname)
    return vim.fs.dirname((vim.fs.find('.git', {
      path = fname,
      upward = true,
    }))[1])
  end,
})
