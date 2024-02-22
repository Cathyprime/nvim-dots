local add   = require("mini.deps").add
local later = require("mini.deps").later

add("kylechui/nvim-surround")
add("Wansmer/treesj")

later(function()
    ---@diagnostic disable-next-line
    require("nvim-surround").setup({
        keymaps = {
            insert = "<c-s>",
            insert_line = "<c-s><c-s>",
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
