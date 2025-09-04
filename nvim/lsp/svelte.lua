local function root_dir(fname)
  return vim.fs.dirname(vim.fs.find({ 'package.json', '.git' }, { upward = true, path = fname })[1])
end

return {
  cmd = { 'svelteserver', '--stdio' },
  filetypes = { 'svelte' },
  root_dir = root_dir,
}
