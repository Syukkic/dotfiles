local lspkind = require('lspkind')
local cmp = require('cmp')
cmp.setup {
       formatting = {
        format = lspkind.cmp_format({
            with_text = true, -- do not show text alongside icons
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
            before = function (entry, vim_item)
                -- Source 显示提示来源
                vim_item.menu = "["..string.upper(entry.source.name).."]"
                return vim_item
            end
        })
    },
}
