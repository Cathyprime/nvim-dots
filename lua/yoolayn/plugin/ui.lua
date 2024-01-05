return {
    {
        "stevearc/dressing.nvim",
        opts = {
            select = {
                telescope = (function()
                    local ivy = require("telescope.themes").get_ivy()
                    local settings = {
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
                        border = true,
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
