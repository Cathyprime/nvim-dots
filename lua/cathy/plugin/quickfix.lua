return {
    {
        "romainl/vim-qf",
        config = function()
            vim.g.qf_auto_quit = 0
            vim.g.qf_max_height = 12
            vim.g.qf_auto_resize = 0
        end
    }
}
