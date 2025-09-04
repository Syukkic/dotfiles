return {
  {
    'nvimtools/none-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local null_ls = require('null-ls')

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.raco_fmt.with({
            command = 'raco',
            args = { 'fmt' },
          }),
          null_ls.builtins.formatting.djlint.with({
            extra_args = { '--quiet', '--reformat', '--indent=2', '-' },
            filetypes = { 'html', 'jinja', 'django', 'htmldjango' },
          }),
          null_ls.builtins.diagnostics.djlint.with({
            extra_args = { '--quiet' },
            filetypes = { 'html', 'jinja', 'django', 'htmldjango' },
          }),
          null_ls.builtins.formatting.black.with({
            extra_args = { '--fast', '--skip-string-normalization' },
            filetypes = { 'python' },
          }),
          null_ls.builtins.formatting.isort.with({
            filetypes = { 'python' },
          }),
          null_ls.builtins.formatting.shfmt.with({
            filetypes = { 'sh' },
          }),
          null_ls.builtins.formatting.prettier.with({
            extra_args = { '--single-quote' },
            filetypes = {
              'javascript',
              'typescript',
              'typescriptreact',
              'javascriptreact',
              'css',
              'html',
              'json',
              'yaml',
              'markdown',
              'svelte',
            },
          }),
          null_ls.builtins.formatting.stylua.with({
            filetypes = { 'lua' },
            extra_args = { '--indent-type', 'Spaces', '--indent-width', '2', '--quote-style', 'AutoPreferSingle' },
          }),
          null_ls.builtins.formatting.ocamlformat.with({
            filetypes = { 'ocaml' },
          }),
          -- null_ls.builtins.diagnostics.sqlfluff.with({
          --   extra_args = { '--dialect', 'postgres', '--exclude-rules', 'LT01,L009', '--rules', 'LT10,ST05' },
          -- }),
          -- null_ls.builtins.formatting.sqlfluff.with({
          --   extra_args = { '--dialect', 'postgres', '--exclude-rules', 'LT01,L009', '--rules', 'LT10,ST05' },
          -- }),
        },
      })
    end,
  },
}
