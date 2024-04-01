require("mini.deps").add({
    source = "stevearc/oil.nvim",
    depends = {
        "nvim-tree/nvim-web-devicons"
    }
})
require("mini.deps").later(function()
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
    })
    vim.keymap.set("n", "-", "<cmd>Oil<cr>")
end)
