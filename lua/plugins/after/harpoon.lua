local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
local tmux = require("harpoon.tmux")
local term = 1

local function send(command)
    tmux.sendCommand(term, command)
    tmux.gotoTerminal(term)
end


return {
    "ThePrimeagen/harpoon",
    keys = {
        -- harpoon usage
        {
            "<leader>h",
            function() ui.toggle_quick_menu() end,
            {desc = "harpoon", }
        },
        {
            "<leader>a",
            function() mark.add_file() end,
            {desc = "add file", }
        },

        -- file navigation
        {
            "<C-f>",
            function() ui.nav_file(1) end,
            {desc = "go to first", }
        },
        {
            "<C-s>",
            function() ui.nav_file(2) end,
            {desc = "go to second", }
        },
        {
            "<c-n>",
            function() ui.nav_file(3) end,
            { desc = "go to next" }
        },
        {
            "<c-h>",
            function() ui.nav_file(4) end,
            {desc = "go to harpoon", }
        },

        -- tmux integration
        {
            "<c-j>",
            function () tmux.gotoTerminal(term) end,
            {desc = "go to term"}
        },
        {
            "<c-k>",
            function () tmux.gotoTerminal(2) end,
            {desc = "go to second term"}
        },
        {
            "<leader>tc",
            function()
                local command = vim.fn.input({ prompt = "bash: " })
                send(command)
            end,
            {desc = "tmux custom", }},
        {
            "<leader>ty",
            function () send("yarn") end,
            { desc = "tmux yarn" }
        },
        {
            "<leader>tr",
            function () send("cargo") end,
            {desc = "tmux rust"}
        },
    }
}
