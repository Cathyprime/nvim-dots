return {
    "tpope/vim-abolish",
    {
        "monaqa/dial.nvim",
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
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
        event = "InsertEnter",
        opts = {
            keymaps = {
                insert = false,
                insert_line = false,
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
            surrounds = {
                t = {
                    add = function()
                        local type = require("nvim-surround.config").get_input("Enter the type name: ")
                        return { { type .. "<" }, { ">" }}
                    end,
                    find = function()
                        local c = require("nvim-surround.config")
                        if vim.g.loaded_nvim_treesitter then
                            local selection = c.get_selection({
                                query = {
                                    capture = "@type.outer",
                                    type = "textobjects",
                                }
                            })
                            if selection then
                                return selection
                            end
                        end
                        return c.get_selection({ pattern = "[^=%s%<%>{}]+%b()" })
                    end,
                    delete = "^(.-%<)().-(%>)()$",
                    change = {
                        target = "^.-([%w_]+)()%<.-%>()()$",
                        replacement = function()
                            local result = require("nvim-surround.config").get_input("Enter the type name: ")
                            if result then
                                return { { result }, { "" } }
                            end
                        end
                    }
                }
            }
        },
    }
}
