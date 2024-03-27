local icons = require("util.icons").icons

require("mini.deps").add({
    source = "nvim-neo-tree/neo-tree.nvim",
    depends = {
        -- "nvim-lua/plenary.nvim", installed by lua rocks
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
        "miversen33/netman.nvim",
    },
})

require("mini.deps").later(function()
    require("netman").setup()
    require("neo-tree").setup({
        window = {
            mappings = {
                ["<space>"] = "noop",
                ["O"] = "toggle_node",
                ["E"] = "expand_all_nodes",
                ["/"] = "noop",
                ["w"] = "noop",
            },
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
    })
    vim.keymap.set("n", "<leader>e", function()
        local reveal_file = vim.fn.expand("%:p")
        require("neo-tree.command").execute({
            action = "focus",
            source = "filesystem",
            position = "left",
            reveal_file = reveal_file,
            reveal_force_cwd = true,
        })
    end)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
end)
