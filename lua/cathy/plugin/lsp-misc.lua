require("mini.deps").add("j-hui/fidget.nvim")

require("mini.deps").later(function()
    require("fidget").setup({
        progress = {
            display = {
                progress_icon = {
                    pattern = "moon",
                    period = 1,
                },
            },
        },
        notification = {
            window = {
                winblend = 0,
            },
        }
    })
end)
