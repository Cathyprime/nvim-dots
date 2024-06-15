require("mini.deps").add({
    source = "stevearc/oil.nvim",
    -- depends = {
    --     "nvim-tree/nvim-web-devicons", -- installed by lua rocks
    -- }
})

require("mini.deps").now(function()
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
            ["gx"] = "",
            ["<a-cr>"] = "actions.open_external",
        },
        view_options = {
            natural_order = true,
            show_hidden = true,
            is_always_hidden = function(name)
                return name == ".." or name == ".git"
            end
        }
    })
    vim.keymap.set("n", "-", "<cmd>Oil<cr>")
end)
