return {
    "JellyApple102/easyread.nvim",
    config = function()
        require("easyread").setup({
            filetypes = {},
        })
    end,
    cmd = "EasyreadToggle",
    keys = {
        {
            "<leader>uR",
            ":EasyreadToggle<CR>",
            desc = "Bionic Reading",
        },
    },
    ft = "txt",
}
