local add   = require("mini.deps").add
local later = require("mini.deps").later

add("kylechui/nvim-surround")
add({
    source = "windwp/nvim-autopairs",
    depends = { "hrsh7th/nvim-cmp", }
})

later(function()
    ---@diagnostic disable-next-line
    require("nvim-surround").setup({
        keymaps = {
            insert = "<c-d>",
            insert_line = "<c-s>",
            normal = "s",
            normal_cur = "ss",
            normal_line = "S",
            normal_cur_line = "SS",
            visual = "s",
            visual_line = "S",
            delete = "ds",
            change = "cs",
            change_line = "cS",
        }
    })
end)

later(function()
    require("nvim-autopairs").setup()
    require("nvim-autopairs").remove_rule('"')
    require("nvim-autopairs").remove_rule("'")
    require("nvim-autopairs").remove_rule('`')
    require("nvim-autopairs").remove_rule('(')
    require("nvim-autopairs").remove_rule('[')
    require("nvim-autopairs").remove_rule('{')
    local ok, _ = pcall(require, "cmp")
    if ok then
        require("cathy.config.cmp-pairs")
    end
    require("cathy.config.pair-customrules")
end)
