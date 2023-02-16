return {
    "nvim-telescope/telescope.nvim",
    opts = {
        defaults = {
            mappings = {
                i = {
                    ["<C-j>"] = function(...)
                        return require("telescope.actions").move_selection_next(...)
                    end,
                    ["<C-k>"] = function(...)
                        return require("telescope.actions").move_selection_previous(...)
                    end,
                },
            },
        },
    },
    keys = {
        {
            "<leader>uc",
            require("lazyvim.util").telescope("colorscheme", { enable_preview = true }),
            desc = "colorscheme with preview",
        },
    },
}
