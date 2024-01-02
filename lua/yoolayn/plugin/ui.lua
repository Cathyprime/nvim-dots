return {
    {
        "stevearc/dressing.nvim",
        opts = {}
    },
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            local config = require("yoolayn.config.lualine")
            require("lualine").setup(config)
        end
    }
}
