local icons = require("util.icons").icons
return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        opts = {
            window = {
                mappings = {
                    ["<space>"] = "noop",
                    ["O"] = "toggle_node",
                    ["E"] = "expand_all_nodes",
                    ["/"] = "noop",
                },
            },
            filesystem = {
                follow_current_file = {
                    enabled = true
                }
            },
            source_selector = {
                winbar = true,
                tabs_layout = "equal",
                content_layout = "center",
                sources = {
                    {
                        source = "filesystem",
                        display_name = string.format(" %s Files ", icons.Directory)
                    },
                    {
                        source = "remote",
                        display_name = string.format(" %s Remote ", icons.Web)
                    },
                    {
                        source = "document_symbols",
                        display_name = string.format(" %s Symbols ", icons.Function)
                    },
                },
            },
            sources = { "filesystem", "document_symbols", "netman.ui.neo-tree" }
        },
        keys = {
            { "<leader>e", function()
                local reveal_file = vim.fn.expand("%:p")
                require("neo-tree.command").execute({
                    action = "focus",
                    source = "filesystem",
                    position = "bottom",
                    reveal_file = reveal_file,
                    reveal_force_cwd = true,
                })
            end},
            { "<leader>fe", function()
                local reveal_file = vim.fn.expand("%:p")
                require("neo-tree.command").execute({
                    action = "focus",
                    source = "filesystem",
                    position = "current",
                    reveal_file = reveal_file,
                    reveal_force_cwd = true,
                })
            end},
        },
        cmd = { "Neotree" }
    },
    {
        "miversen33/netman.nvim",
        config = true
    }
}
