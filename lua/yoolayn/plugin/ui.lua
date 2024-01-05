local telescope_config = require("util.telescope-config")

return {
    {
        "stevearc/dressing.nvim",
        opts = {
            select = {
                telescope = (function()
                    local ivy = require("telescope.themes").get_ivy()
                    local settings = {
                        borderchars = telescope_config.borderchars,
                        layout_config = telescope_config.layout_config,
                        border = telescope_config.border,
                    }
                    return vim.tbl_deep_extend("force", ivy, settings)
                end)()
            }
        }
    },
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            local config = require("yoolayn.config.lualine")
            require("lualine").setup(config)
        end
    }
}
