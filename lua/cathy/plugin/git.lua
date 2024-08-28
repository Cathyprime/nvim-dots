return {
    {
        "sindrets/diffview.nvim",
        keys = {
            { "<leader>gd", "<cmd>DiffviewOpen<cr>" },
            { "<leader>gc", "<cmd>DiffviewClose<cr>" }
        },
        config = true
    },
    {
        "FabijanZulj/blame.nvim",
        config = true,
    },
    {
        "NeogitOrg/neogit",
        keys = {
            { "ZG",  function()
                require("neogit").open({ kind = "split" })
            end }
        },
        config = true,
        init =  function()
            vim.api.nvim_create_autocmd("Filetype", {
                group = vim.api.nvim_create_augroup("cathy_neogit", { clear = true }),
                pattern = "Neogit*",
                command = "setlocal foldcolumn=0"
            })
        end
    },
}
