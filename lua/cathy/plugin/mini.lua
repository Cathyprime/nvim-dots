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
            left = "<",
            right = ">",
            down = "<m-j>",
            up = "<m-k>",

            line_left = "",
            line_right = "",
            line_down = "<m-j>",
            line_up = "<m-k>",
        }
    })

    require("mini.clue").setup({
        triggers = {
            { mode = "n", keys = "<leader>z" }
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
        }
    })
end)
