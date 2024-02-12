local md = require("mini.deps")

md.add("echasnovski/mini.indentscope")
md.add("echasnovski/mini.align")
md.add("echasnovski/mini.operators")
md.add("echasnovski/mini.starter")
md.add("echasnovski/mini.comment")

md.now(function()
    local config = require("yoolayn.config.ministarter")
    require("mini.starter").setup(config)
end)

md.later(function()
    require("mini.indentscope").setup({symbol = ""})
    require("mini.align").setup({
        mappings = {
            start = "",
            start_with_preview = "ga",
        },
    })
    require("mini.operators").setup({
        sort = {
            prefix = "",
            func = nil
        }
    })
    require("mini.comment").setup({
        options = {
            custom_commentstring = function()
                return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
            end,
        },
    })
end)
