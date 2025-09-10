vim.filetype.add({
  extension = {
    beancount = 'beancount',
    bean = 'beancount',
  },
})

vim.lsp.config('beancount', {
  cmd = { 'beancount-language-server', '--stdio' },
  filetypes = { 'bean', 'beancount' },
  init_options = {
    journal_file = vim.fn.expand('~/personal/finance/main.bean'),
    -- formatting = {
    --   prefix_width = 30,
    --   num_width = 10,
    --   -- currency_column = 60,
    --   number_currency_spacing = 1,
    -- },
  },
})
