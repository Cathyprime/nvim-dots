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
                "permissions",
                "size",
                "mtime",
                "icon",
            },
            keymaps = {
                ["gx"] = false,
                ["gX"] = { "<cmd>Browse<cr>", desc = "open in browser" },
                ["<A-cr>"] = "actions.open_external",
                ["gq"] = { "<cmd>close<cr>", desc = "close buffer" },
                ["<C-t>"] = "actions.open_terminal",
                ["<C-q>"] = "actions.send_to_qflist",
                ["gyy"] = "actions.yank_entry",
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
                    return name == ".." or name == ".git"
                end,
            },
        })
        vim.keymap.set("n", "<leader>d", "<cmd>sp | Oil<cr>")
        vim.keymap.set("n", "-", "<cmd>Oil<cr>")
    end,
}
