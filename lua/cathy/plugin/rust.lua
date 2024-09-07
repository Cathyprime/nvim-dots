return {
    "mrcjkb/rustaceanvim",
    ft = "rust",
    init = function()
        vim.g.rustaceanvim = {
            dap = {
                disable = true
            },
            tools = {
                float_win_config = {
                    border = "single",
                },
            },
        }
    end
}
