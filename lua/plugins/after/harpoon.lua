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
            "<C-h>f",
            function() require("harpoon.ui").nav_file(1) end,
            {desc = "go to first", }
        },
        {
            "<C-h>s",
            function() require("harpoon.ui").nav_file(2) end,
            {desc = "go to second", }
        },
        {
            "<c-h>n",
            function() require("harpoon.ui").nav_file(3) end,
            { desc = "go to next" }
        },
        {
            "<c-h>h",
            function() require("harpoon.ui").nav_file(4) end,
            {desc = "go to harpoon", }
        },
    }
}
