require("mini.deps").add({
    source = "nvim-neorg/neorg",
    depends = { "nvim-lua/plenary.nvim" },
})

require("mini.deps").later(function()
    require("neorg").setup({
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
            ["core.ui.calendar"] = {},
            ["core.dirman"] = {
                config = {
                    workspaces = { notes = "~/Documents/neorg/notes" },
                    default_workspace = "notes"
                }
            }
        }
    })
end)
