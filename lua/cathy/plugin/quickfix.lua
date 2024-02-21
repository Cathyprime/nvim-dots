local add = require("mini.deps").add
local later = require("mini.deps").later

add("kevinhwang91/nvim-bqf")
---@diagnostic disable-next-line
require("bqf").setup({
    func_map = {
        open = "<CR>",
        openc = "o",
        drop = "",
        tabdrop = "",
        tab = "",
        tabb = "",
        tabc = "",
        split = "",
        vsplit = "",
        prevfile = "",
        nextfile = "",
        prevhist = "<",
        nexthist = ">",
        lastleave = "",
        stoggleup = "",
        stoggledown = "<Tab>",
        stogglevm = "<Tab>",
        stogglebuf = "",
        sclear = "z<Tab>",
        pscrollup = "",
        pscrolldown = "",
        pscrollorig = "",
        ptogglemode = "P",
        ptoggleitem = "",
        ptoggleauto = "p",
        filter = "zn",
        filterr = "zN",
        fzffilter = "",
    },
    ---@diagnostic disable-next-line
    preview = {
        auto_preview = false,
    },
})

add("yorickpeterse/nvim-pqf")
later(function()
    local icons = require("util.icons").icons
    require("pqf").setup({
        signs = {
            error = icons.Error,
            warning = icons.Warning,
            info = icons.Info,
            hint = icons.Hint
        }
    })
end)
