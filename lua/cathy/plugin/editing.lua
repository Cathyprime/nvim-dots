local add   = require("mini.deps").add
local later = require("mini.deps").later

add("kylechui/nvim-surround")
add({
    source = "windwp/nvim-autopairs",
    depends = { "hrsh7th/nvim-cmp", }
})
add("Wansmer/treesj")

later(function()
    ---@diagnostic disable-next-line
    require("nvim-surround").setup({
        keymaps = {
            insert = "<c-s><c-s>",
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
    require("treesj").setup({
        use_default_keymaps = false,
        max_join_length = 160,
    })
    vim.keymap.set("n", "gs", function()
        require("treesj").toggle()
    end)
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
