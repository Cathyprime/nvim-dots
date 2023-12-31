return {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("neorg").setup({
            load = {
                ["core.defaults"] = {},
                ["core.concealer"] = {
                    config = {
                        icons = {
                            heading = false,
                        }
                    }
                },
                ["core.keybinds"] = {
                    config = {
                        hook = function(keybinds)
                            keybinds.map("norg", "n", "gf", "<cmd>Neorg keybind all core.looking-glass.magnify-code-block<cr>")
                        end
                    }
                },
                ["core.export"] = { config = { export_dir = "~/Documents/neorg/exported" } },
                ["core.ui.calendar"] = {},
                ["core.dirman"] = {
                    config = {
                        workspaces = { notes = "~/Documents/neorg/notes" },
                        default_workspace = "notes"
                    }
                }
            }
        })
    end
}
