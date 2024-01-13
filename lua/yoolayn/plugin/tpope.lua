return {
    "tpope/vim-dispatch",
    {
        "tpope/vim-fugitive",
        cmd ={ "G", "Gclog" },
        keys = {
            {
                "<leader>gg",
                "<cmd>G<cr>"
            },
        }
    },
}
