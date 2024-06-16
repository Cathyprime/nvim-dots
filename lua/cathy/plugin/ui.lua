local telescope_config = require("util.telescope-config")

require("mini.deps").now(function()
    require("dressing").setup({
        input = {
            insert_only = false,
            start_in_insert = true,
        },
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
    })
end)

require("mini.deps").add({
    source = "nvim-lualine/lualine.nvim",
    depends = {
        "rebelot/kanagawa.nvim",
        "AndreM222/copilot-lualine"
    }
})

-- require("mini.deps").now(function()
--     local config = require("cathy.config.lualine")
--     ---@diagnostic disable-next-line
--     require("lualine").setup(config)
-- end)
