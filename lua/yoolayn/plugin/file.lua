local icons = require("util.icons").icons
return {
    {
        "stevearc/oil.nvim",
        opts = {
            default_file_explorer = true,
            columns = {
                "permissions",
                "size",
                "mtime",
                "icon",
            },
            keymaps = {
                ["<c-c>q"] = "actions.close"
            }
        },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function(opts)
            require("oil").setup(opts.opts)
            vim.keymap.set("n", "<leader>e", "<cmd>botright 15split | Oil<cr>", { silent = true })
            vim.keymap.set("n", "<leader>fe", "<cmd>Oil<cr>", { silent = true })
            vim.keymap.set("n", "<leader>fE", "<cmd>vert Oil<cr>", { silent = true })
        end
    },
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
                }
            },
            source_selector = {
                winbar = true,
                sources = {
                    {
                        source = "filesystem",
                        display_name = string.format(" %s Files ", icons.Directory)
                    },
                    {
                        source = "document_symbols",
                        display_name = string.format(" %s Symbols ", icons.Function)
                    },
                    {
                        source = "remote",
                        display_name = string.format(" %s Remote ", icons.Web)
                    },
                },
            },
            sources = { "filesystem", "git_status", "document_symbols", "netman.ui.neo-tree", "buffers" }
        },
        keys = {
            { "<leader>n", "<cmd>Neotree<cr>" }
        },
        cmd = { "Neotree" }
    },
    {
        "miversen33/netman.nvim",
        config = true
    }
}
