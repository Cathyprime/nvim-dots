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
    config = function()
        require("telescope").load_extension("notify")
    end,
}
