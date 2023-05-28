return {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    keys = {
        {
            "<leader>e",
            function()
                require("neo-tree.command").execute({ toggle = true, dir = require("lazyvim.util").get_root() })
            end,
            desc = "Explorer NeoTree (root dir)",
        },
        {
            "<leader>E",
            function()
                require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
            end,
            desc = "Explorer NeoTree (cwd)",
        },
        { "<leader>fe", false },
        { "<leader>fE", false },
    },
    opts = {
        close_if_last_window = true,
        source_selector = {
            winbar = true,
            statusline = false, -- toggle to show selector on statusline
            content_layout = "center",
            tabs_layout = "equal",
            sources = {
                {
                    source = "filesystem",
                    display_name = "  Files",
                },
                {
                    source = "buffers",
                    display_name = "  Buffers",
                },
                {
                    source = "git_status",
                    display_name = "  Git",
                },
                {
                    source = "diagnostics",
                    display_name = " 裂LSP",
                },
            },
        },
        filesystem = {
            bind_to_cwd = true,
            follow_current_file = true,
            use_libuv_file_watcher = true,
        },
        default_component_configs = {
            icon = {
                folder_closed = "",
                folder_open = "",
                folder_empty = "",
                default = " ",
                highlight = "NeoTreeFileIcon",
            },
            name = {
                trailing_slash = true,
                use_git_status_colors = true,
                highlight = "NeoTreeFileName",
            },
            indent = {
                with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
                expander_collapsed = "",
                expander_expanded = "",
                expander_highlight = "NeoTreeExpander",
            },
        },
    },
}
