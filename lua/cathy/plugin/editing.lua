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
            vim.keymap.set("n", "<c-g>",  function() mani("increment", "normal", "case") end)
            vim.keymap.set("v", "g<C-x>", function() mani("decrement", "gvisual") end)
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
                        if type then
                            return { { type .. "<" }, { ">" }}
                        end
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
                            local type = require("nvim-surround.config").get_input("Enter the type name: ")
                            if type then
                                return { { type }, { "" } }
                            end
                        end
                    }
                }
            }
        },
    },
    {
        "jake-stewart/multicursor.nvim",
        branch = "1.0",
        config = function()
            local mc = require("multicursor-nvim")

            mc.setup()

            -- Add a cursor and jump to the next word under cursor.
            vim.keymap.set({"n", "v"}, "<c-s-n>", function() mc.addCursor("*N") end)
            vim.keymap.set({"n", "v"}, "<c-n>", function() mc.addCursor("*n") end)

            -- Jump to the next word under cursor but do not add a cursor.
            vim.keymap.set({"n", "v"}, "<c-s>", function() mc.skipCursor("*n") end)
            vim.keymap.set({"n", "v"}, "<c-s-s>", function() mc.skipCursor("*N") end)

            -- Rotate the main cursor.
            vim.keymap.set({"n", "v"}, "<left>", mc.nextCursor)
            vim.keymap.set({"n", "v"}, "<right>", mc.prevCursor)

            -- Delete the main cursor.
            vim.keymap.set({"n", "v"}, "<leader>x", mc.deleteCursor)
            vim.keymap.set("v", "<c-q>", mc.visualToCursors)

            vim.keymap.set("n", "<esc>", function()
                if not mc.cursorsEnabled() then
                    mc.enableCursors()
                elseif mc.hasCursors() then
                    mc.clearCursors()
                else
                    vim.api.nvim_feedkeys(vim.keycode"<esc>", "n", false)
                end
            end)

            -- Align cursor columns.
            vim.keymap.set("n", "<leader>ga", mc.alignCursors)

            -- Split visual selections by regex.
            vim.keymap.set("v", "<leader>S", mc.splitCursors)

            -- Append/insert for each line of visual selections.
            vim.keymap.set("v", "I", mc.insertVisual)
            vim.keymap.set("v", "A", function()
                if vim.fn.mode() == vim.keycode("<c-v>") then
                    vim.fn.feedkeys("A", "n")
                else
                    mc.appendVisual()
                end
            end)

            -- match new cursors within visual selections by regex.
            vim.keymap.set("v", "M", mc.matchCursors)

            -- Rotate visual selection contents.
            vim.keymap.set("v", "<leader>T", function() mc.transposeCursors(-1) end)
            vim.keymap.set("v", "<leader>t", function() mc.transposeCursors(1) end)
        end,
    }
}
