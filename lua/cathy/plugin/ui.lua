-- local telescope_config = require("util.telescope-config")
local telescope_config = {
    borderchars = {
        prompt  = { "",  "",  "",  "",  "",  "",  "",  ""  },
        results = { "",  "",  "",  "",  "",  "",  "",  ""  },
        preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    },
    layout_config = {
        prompt_position = "bottom",
        height = 14,
        preview_width = 0.60,
    },
    border = true
}

require("mini.deps").add("stevearc/dressing.nvim")

require("mini.deps").now(function()
    require("dressing").setup({
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
    depends = {"rebelot/kanagawa.nvim"}
})

require("mini.deps").now(function()
    local config = require("cathy.config.lualine")
    require("lualine").setup(config)
end)
