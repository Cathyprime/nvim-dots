return {
    "echasnovski/mini.files",
    config = function()
        require("mini.files").setup()
    end,
    keys = {
        {
            "<leader>E",
            ":lua MiniFiles.open(vim.api.nvim_buf_get_name(0), false)<CR>",
            desc = "MiniFiles",
        },
    },
}
