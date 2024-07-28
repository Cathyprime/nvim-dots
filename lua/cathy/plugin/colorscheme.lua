return {
    {
        "sainnhe/everforest",
        config = function()
            vim.g.everforest_background = "soft"
        end
    },
    {
        "Cathyprime/kanagawa_remix",
        dependencies = {
            "rktjmp/lush.nvim"
        },
        config = function()
            if vim.o.background == "dark" then
                vim.cmd.colorscheme "kanagawa_remix"
            else
                vim.cmd.colorscheme "everforest"
            end
        end
    }
}
