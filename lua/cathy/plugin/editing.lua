return {
    "tpope/vim-abolish",
    {
        "zbirenbaum/copilot.lua",
        event = { "InsertEnter", "CmdlineEnter" },
        config = function()
            require("copilot").setup({
                panel = { enabled = false },
                suggestion = {
                    enabled = true,
                    auto_trigger = false,
                    keymap = {
                        accept = "<m-y>",
                        accept_word = "<m-w>",
                        accept_line = "<m-l>",
                        next = "<m-n>",
                        prev = "<m-p>",
                        dismiss = "<m-e>",
                    },
                },
                filetypes = {
                    cpp = true,
                }
            })
        end
    },
    {
        "monaqa/dial.nvim",
        event = { "InsertEnter", "BufReadPost", "BufWritePost", "BufNewFile" },
        config = function()
            local dial = require("cathy.config.dial")
            require("dial.config").augends:register_group(dial.register_group)
            require("dial.config").augends:on_filetype(dial.on_filetype)

            local mani = require("dial.map").manipulate
            vim.keymap.set("n", "<C-a>",  function() mani("increment", "normal") end)
            vim.keymap.set("n", "<C-x>",  function() mani("decrement", "normal") end)
            vim.keymap.set("n", "g<C-a>", function() mani("increment", "gnormal") end)
            vim.keymap.set("n", "g<C-x>", function() mani("decrement", "gnormal") end)
            vim.keymap.set("v", "<C-a>",  function() mani("increment", "visual") end)
            vim.keymap.set("v", "<C-x>",  function() mani("decrement", "visual") end)
            vim.keymap.set("v", "g<C-a>", function() mani("increment", "gvisual") end)
            vim.keymap.set("v", "g<C-x>", function() mani("decrement", "gvisual") end)
            vim.keymap.set("n", "<c-g>",  function() mani("increment", "normal", "case") end)
        end
    },
    {
        "kylechui/nvim-surround",
        config = function()
            vim.api.nvim_create_autocmd("InsertEnter", {
                once = true,
                callback = function()
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
                        },
                    })
                end,
            })
        end
    }
}
