return {
    {
        "romainl/vim-qf",
        config = function()
            vim.g.qf_auto_quit = 0
            vim.g.qf_max_height = 12
            vim.g.qf_auto_resize = 0
        end
    },
    {
        "stevearc/quicker.nvim",
        config = function()
            print("setting up quicker")
            require("quicker").setup({
                keys = {
                    {
                        ">",
                        function()
                            require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
                        end,
                        desc = "Expand quickfix context",
                    },
                    {
                        "<",
                        function()
                            require("quicker").collapse()
                        end,
                        desc = "Collapse quickfix context",
                    },
                },
            })
        end,
        keys = {
            { "<leader>q", function()
                if vim.g.dispatch_ready then
                    vim.g["dispatch_ready"] = false
                    vim.cmd("Copen")
                    require("quicker").toggle()
                end
                require("quicker").toggle()
            end }
        }
    }
}
