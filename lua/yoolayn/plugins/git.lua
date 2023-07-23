return {
    {
        "NeogitOrg/neogit",
        dependencies = "nvim-lua/plenary.nvim",
        opts = {
            disable_signs = true,
        },
        keys = {
            {
                "<leader>gg",
                "<cmd>Neogit<cr>",
                desc = "Open Neogit",
            },
        },
    },
}
