local lsp = vim.lsp
local M = { path = {} }

M.default_config = {
  log_level = lsp.protocol.MessageType.Warning,
  message_level = lsp.protocol.MessageType.Warning,
  settings = vim.empty_dict(),
  init_options = vim.empty_dict(),
  handlers = {},
  autostart = true,
  capabilities = lsp.protocol.make_client_capabilities(),
}

return {
  cmd = { 'svelteserver', '--stdio' },
  filetypes = { 'svelte' },
  root_dir = function(startpath)
    return M.search_ancestors(startpath, matcher)
  end,
}
