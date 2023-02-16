return {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    ft = "norg",
    cmd = "Neorg",
    opts = {
        load = {
            ["core.defaults"] = {}, -- Loads default behaviour
            ["core.norg.concealer"] = {}, -- Adds pretty icons to your documents
            ["core.integrations.telescope"] = {}, -- telescope integration to add links and search headings
            ["core.integrations.treesitter"] = {}, -- treesitter integration
            ["core.integrations.nvim-cmp"] = {}, -- autocompletion
            ["core.norg.dirman"] = { -- Manages Neorg workspaces
                config = {
                    workspaces = {
                        notes = "~/notes",
                        testing = "~/notes/testing",
                        documentation = "~/notes/documentation",
                    },
                },
            },
            ["core.norg.dirman.utils"] = {}, -- utilities for neorg
        },
    },
    dependencies = { { "nvim-lua/plenary.nvim", "nvim-neorg/neorg-telescope" } },
}
