return {
    {
        "johmsalas/text-case.nvim",
        opts = {}
    },
    {
        "monaqa/dial.nvim",
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        config = function()
            local dial = require("cathy.config.dial")
            require("dial.config").augends:register_group(dial.register_group)
            require("dial.config").augends:on_filetype(dial.on_filetype)

            local mani = require("dial.map").manipulate
            vim.keymap.set("n", "<C-a>",  function() mani("increment", "normal")  end)
            vim.keymap.set("n", "<C-x>",  function() mani("decrement", "normal")  end)
            vim.keymap.set("n", "g<C-a>", function() mani("increment", "gnormal") end)
            vim.keymap.set("n", "g<C-x>", function() mani("decrement", "gnormal") end)
            vim.keymap.set("v", "<C-a>",  function() mani("increment", "visual")  end)
            vim.keymap.set("v", "<C-x>",  function() mani("decrement", "visual")  end)
            vim.keymap.set("v", "g<C-a>", function() mani("increment", "gvisual") end)
            vim.keymap.set("v", "g<C-x>", function() mani("decrement", "gvisual") end)
            vim.keymap.set("n", "<c-g>",  function() mani("increment", "normal", "case") end)
        end
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
            vim.keymap.set({"n", "v"}, "<c-s-s>", function() mc.skipCursor("*N") end)
            vim.keymap.set({"n", "v"}, "<c-s>", function() mc.skipCursor("*n") end)

            -- Rotate the main cursor.
            vim.keymap.set({"n", "v"}, "<c-j>", mc.nextCursor)
            vim.keymap.set({"n", "v"}, "<c-k>", mc.prevCursor)

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
            vim.keymap.set("n", "ga", mc.alignCursors)

            -- Split visual selections by regex.
            vim.keymap.set("v", "<leader>S", mc.splitCursors)

            -- Append/insert for each line of visual selections.
            vim.keymap.set("v", "I", mc.insertVisual)
            vim.keymap.set("v", "A", mc.appendVisual)

            -- match new cursors within visual selections by regex.
            vim.keymap.set("v", "M", mc.matchCursors)

            -- Rotate visual selection contents.
            vim.keymap.set("v", "gt", function() mc.transposeCursors(1) end)
            vim.keymap.set("v", "gT", function() mc.transposeCursors(-1) end)
        end,
    }
}
