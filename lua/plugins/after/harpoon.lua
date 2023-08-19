local term = 0
return {
    "ThePrimeagen/harpoon",
    keys = {
        -- harpoon usage
        {
            "<leader>h",
            function() require("harpoon.ui").toggle_quick_menu() end,
            {desc = "harpoon", }
        },
        {
            "<leader>a",
            function() require("harpoon.mark").add_file() end,
            {desc = "add file", }
        },

        -- file navigation
        {
            "<C-f>",
            function() require("harpoon.ui").nav_file(1) end,
            {desc = "go to first", }
        },
        {
            "<C-s>",
            function() require("harpoon.ui").nav_file(2) end,
            {desc = "go to second", }
        },
        {
            "<c-n>",
            function() require("harpoon.ui").nav_file(3) end,
            { desc = "go to next" }
        },
        {
            "<c-h>",
            function() require("harpoon.ui").nav_file(4) end,
            {desc = "go to harpoon", }
        },

        -- tmux integration
        {
            "<c-j>",
            function () require("harpoon.tmux").gotoTerminal(term) end,
            {desc = "go to term"}
        },
        {
            "<c-k>",
            function () require("harpoon.tmux").gotoTerminal(2) end,
            {desc = "go to second term"}
        },
        {
            "<leader>tc",
            function()
                local command = vim.fn.input({ prompt = "bash: " })
                local tmux = require("harpoon.tmux")
                tmux.sendCommand(term, command)
                tmux.gotoTerminal(term)
            end,
            {desc = "tmux custom", }},
        {
            "<leader>ty",
            function ()
                local tmux = require("harpoon.tmux")
                tmux.sendCommand(term, "yarn")
                tmux.gotoTerminal(term)
            end,
            { desc = "tmux yarn" }
        },
        {
            "<leader>tr",
            function ()
                local tmux = require("harpoon.tmux")
                tmux.sendCommand(term, "cargo")
                tmux.gotoTerminal(term)
            end,
            {desc = "tmux rust"}
        },
    }
}
