require("which-key").register({
    ["<leader>"] = {
        h = {
            name = "+harpoon",
        },
    },
})

return {
    "ThePrimeagen/harpoon",
    dependencies = {
        "nvim-telescope/telescope.nvim",
    },
    keys = {
        {
            "<leader>hh",
            function()
                require("harpoon.ui").toggle_quick_menu()
            end,
            desc = "Menu",
        },
        {
            "<leader>hm",
            function()
                require("harpoon.mark").add_file()
            end,
            desc = "Add File",
        },
        {
            "<leader>hn",
            function()
                require("harpoon.ui").nav_next()
            end,
            desc = "Next file",
        },
        {
            "<leader>hp",
            function()
                require("harpoon.ui").nav_prev()
            end,
            desc = "Previous file",
        },
        {
            "<leader>hf",
            ":Telescope harpoon marks<CR>",
            desc = "find marks",
        },
    },
    config = function()
        require("telescope").load_extension("harpoon")
    end,
}
