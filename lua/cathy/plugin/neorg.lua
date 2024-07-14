vim.keymap.set("n", "<leader>n", "<cmd>Neorg<cr>")

return {
    {
        "nvim-neorg/neorg",
        build = false, -- disable the build script that currently uses luarocks.nvim
        opts = {
            load = {
                ["core.defaults"] = {},
                ["core.concealer"] = {
                    config = {
                        icons = {
                            heading = false,
                            code_block = {
                                highlight = "",
                                spell_check = false,
                            }
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
                ["core.dirman"] = {
                    config = {
                        workspaces = { notes = "~/Documents/neorg/notes" },
                        default_workspace = "notes"
                    }
                }
            }
        },
    }
}
