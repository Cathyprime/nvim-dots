return {
    {
        "johmsalas/text-case.nvim",
        opts = {
            default_keymappings_enabled = false,
        }
    },
    {
        "monaqa/dial.nvim",
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        config = function()
            local dial = require("cathy.config.dial")
            require("dial.config").augends:register_group(dial.register_group)
            require("dial.config").augends:on_filetype(dial.on_filetype)

            local mani = require("dial.map").manipulate
            vim.keymap.set("n", "<C-a>",  function() mani("increment", "normal")         end)
            vim.keymap.set("n", "<C-x>",  function() mani("decrement", "normal")         end)
            vim.keymap.set("n", "g<C-a>", function() mani("increment", "gnormal")        end)
            vim.keymap.set("n", "g<C-x>", function() mani("decrement", "gnormal")        end)
            vim.keymap.set("v", "<C-a>",  function() mani("increment", "visual")         end)
            vim.keymap.set("v", "<C-x>",  function() mani("decrement", "visual")         end)
            vim.keymap.set("v", "g<C-a>", function() mani("increment", "gvisual")        end)
            vim.keymap.set("v", "g<C-x>", function() mani("decrement", "gvisual")        end)
            vim.keymap.set("n", "<c-g>",  function() mani("increment", "normal", "case") end)
        end
    },
    {
        "jake-stewart/multicursor.nvim",
        branch = "1.0",
        config = function()
            local mc = require("multicursor-nvim")
            mc.setup()

            vim.keymap.set("n", "<c-n>",   function() mc.addCursor("*n")  end)
            vim.keymap.set("n", "<c-s-n>", function() mc.addCursor("*N")  end)
            vim.keymap.set("n", "<c-s>",   function() mc.skipCursor("*n") end)
            vim.keymap.set("n", "<c-s-s>", function() mc.skipCursor("*N") end)
            vim.keymap.set("v", "<c-n>",   function() mc.addCursor("*")   end)
            vim.keymap.set("v", "<c-s-n>", function() mc.addCursor("#")   end)
            vim.keymap.set("v", "<c-s>",   function() mc.skipCursor("#")  end)
            vim.keymap.set("v", "<c-s-s>", function() mc.skipCursor("*")  end)
            vim.keymap.set("v", "S", mc.splitCursors)
            vim.keymap.set("v", "M", mc.matchCursors)

            vim.keymap.set("n", "<leader>gv", mc.restoreCursors)

            vim.keymap.set("n", "ga", mc.alignCursors)
            vim.keymap.set("v", "I",  mc.insertVisual)
            vim.keymap.set("v", "A",  mc.appendVisual)

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
        end,
    }
}
