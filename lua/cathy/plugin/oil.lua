require("mini.deps").add({
    source = "stevearc/oil.nvim",
    -- depends = {
    --     "nvim-tree/nvim-web-devicons", -- installed by lua rocks
    -- }
})

require("mini.deps").now(function()
    require("oil").setup({
        default_file_explorer = true,
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
            show_hidden = true
        }
    })
    vim.keymap.set("n", "-", "<cmd>Oil<cr>")
end)
