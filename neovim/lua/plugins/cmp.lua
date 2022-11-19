local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    return
end

require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[-1]:sub(col, col):match "%s" == nil
end

cmp.setup {
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    window = {
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c"}),
        ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c"}),
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c"}),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c"}),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c"}),
        ["<m-o>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),

        ["Tab"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif luasnip.expandable() then
                luasnip.expand()
            elseif check_backspace() then
                fallback()
            else
                fallback()
            end
        end
        ),
    })
}
