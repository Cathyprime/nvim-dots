local permission_hlgroups = {
    ["-"] = "NonText",
    ["r"] = "DiffChange",
    ["w"] = "DiffDelete",
    ["x"] = "DiffAdd",
}

return {
    "stevearc/oil.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("oil").setup({
            default_file_explorer = true,
            skip_confirm_for_simple_edits = true,
            columns = {
                {
                    "permissions",
                    highlight = function(permission_str)
                        local hls = {}
                        for i = 1, #permission_str do
                            local char = permission_str:sub(i, i)
                            table.insert(hls, { permission_hlgroups[char], i - 1, i })
                        end
                        return hls
                    end,
                },
                { "size", highlight = "DiffAdd" },
                { "mtime", highlight = "Function" },
                "icon",
            },
            keymaps = {
                ["gx"] = false,
                ["gX"] = { "<cmd>Browse<cr>", desc = "open in browser" },
                ["<A-cr>"] = "actions.open_external",
                ["gq"] = { "<cmd>close<cr>", desc = "close buffer" },
                ["<C-t>"] = "actions.open_terminal",
                ["<C-q>"] = "actions.send_to_qflist",
                ["gy"] = "actions.yank_entry",
                ["g\\"] = false,
                ["gs"] = false,
                ["~"] = false,
                ["<C-h>"] = false,
                ["`"] = false,
            },
            view_options = {
                natural_order = true,
                show_hidden = true,
                is_always_hidden = function(name)
                    return name == ".."
                end,
            },
        })
        vim.keymap.set("n", "<leader>d", "<cmd>sp | Oil<cr>")
        vim.keymap.set("n", "-", "<cmd>Oil<cr>")
    end,
}
