local sage_status, sage = pcall(require, "lspsage")
if not sage_status then
    return
end

sage.init_lsp_sage({
    move_in_sage = { prev = "<C-k>", next = "<C-j>" },
    finder_action_keys = { open = "<CR>", },
    definition_action_keys = { edit = "<CR>", }
})
