return {
    {
        "kylechui/nvim-surround",
        event = { "BufNewFile", "BufReadPost", "InsertEnter" },
        opts = {
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
        }
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        dependencies = "hrsh7th/nvim-cmp",
        config = function()
            require("nvim-autopairs").setup()
            require("nvim-autopairs").remove_rule('"')
            require("nvim-autopairs").remove_rule("'")
            require("nvim-autopairs").remove_rule('`')
            require("nvim-autopairs").remove_rule('(')
            require("nvim-autopairs").remove_rule('[')
            require("nvim-autopairs").remove_rule('{')
            local ok, _ = pcall(require, "cmp")
            if ok then
                require("yoolayn.config.cmp-pairs")
            end
            require("yoolayn.config.pair-customrules")
        end
    },
    {
        "Wansmer/treesj",
        opts = {
            use_default_keymaps = false,
            max_join_length = 160,
        },
        keys = {
            {
                "gs",
                function()
                    require("treesj").toggle()
                end,
            },
        },
    }
}
