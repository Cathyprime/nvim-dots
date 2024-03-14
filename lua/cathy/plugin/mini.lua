local now = require("mini.deps").now
local later = require("mini.deps").later

now(function()
    local config = require("cathy.config.ministarter")
    require("mini.starter").setup(config)
end)

later(function()

    require("mini.indentscope").setup({
        symbol = "",
    })

    require("mini.align").setup({
        mappings = {
            start = "",
            start_with_preview = "ga",
        },
    })

    require("mini.operators").setup({
        sort = {
            prefix = "",
            func = nil,
        }
    })

    require("mini.comment").setup({
        options = {
            custom_commentstring = function()
                return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
            end,
        },
    })

    require("mini.trailspace").setup()

    require("mini.move").setup({
        mappings = {
            left = "<m-h>",
            right = "<m-l>",
            down = "<m-j>",
            up = "<m-k>",

            line_left = "",
            line_right = "",
            line_down = "<m-j>",
            line_up = "<m-k>",
        }
    })

    local clue = require("mini.clue")
    clue.setup({
        triggers = {
            { mode = "n", keys = "<leader>z" },
            { mode = "n", keys = "<c-w>" },
            { mode = "i", keys = "<c-x>" },
            { mode = "n", keys = "z" },
        },
        clues = {
            { mode = "n", keys = "<leader>z<cr>", postkeys = "<leader>z" },
            { mode = "n", keys = "<leader>zB", postkeys = "<leader>z" },
            { mode = "n", keys = "<leader>zl", postkeys = "<leader>z" },
            { mode = "n", keys = "<leader>zi", postkeys = "<leader>z" },
            { mode = "n", keys = "<leader>zo", postkeys = "<leader>z" },
            { mode = "n", keys = "<leader>zO", postkeys = "<leader>z" },
            { mode = "n", keys = "<leader>zu", postkeys = "<leader>z" },
            { mode = "n", keys = "<leader>zs" },
            { mode = "n", keys = "<leader>zC", postkeys = "<leader>z" },
            { mode = "n", keys = "<c-w><", postkeys = "<c-w>", desc = "decrease width" },
            { mode = "n", keys = "<c-w>>", postkeys = "<c-w>", desc = "increase width" },
            { mode = "n", keys = "<c-w>-", postkeys = "<c-w>", desc = "decrease height" },
            { mode = "n", keys = "<c-w>+", postkeys = "<c-w>", desc = "increase height" },
            { mode = "n", keys = "<c-w>=", postkeys = "<c-w>", desc = "resize" },
            { mode = "n", keys = "zl", postkeys = "z", desc = "move right" },
            { mode = "n", keys = "zh", postkeys = "z", desc = "move left" },
            clue.gen_clues.builtin_completion(),
        }
    })

    require("mini.misc").setup()

    require("mini.splitjoin").setup({
        mappings = {
            toggle = "gs",
        }
    })

    local ai = require("mini.ai")
    ai.setup({
        custom_textobjects = {
            o = ai.gen_spec.treesitter({
                a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                i = { "@block.inner", "@conditional.inner", "@loop.inner" },
            }, {}),
            f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
            c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
        },
        search_method = "cover_or_prev"
    })

end)
