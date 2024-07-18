return {
    "tpope/vim-fugitive",
    dependencies = "tpope/vim-rhubarb",
    config = function()
        vim.keymap.set("n", "ZG", "<cmd>topleft Git<cr>")
        vim.api.nvim_create_autocmd("Filetype", {
            pattern = "fugitive",
            callback = function()
                vim.keymap.set("n", "<tab>", "=", { buffer = true, remap = true })
            end,
        })
    end
}
