require("easyread").setup({
    fileTypes = {}
})

vim.keymap.set("n", "<leader>U", ":EasyreadToggle<cr>", { desc = "toggle easier reading", silent = true })
