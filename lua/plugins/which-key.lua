return {
    "folke/which-key.nvim",
    config = function()
        require("which-key").setup({
            plugins = {
                presets = {
                    operators = false,
                },
            },
        })
    end,
}
