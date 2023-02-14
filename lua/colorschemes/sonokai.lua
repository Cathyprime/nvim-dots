vim.cmd('let g:sonokai_style="andromeda"')
vim.cmd("let g:sonokai_transparent_background=1")

return {
    "sainnhe/sonokai",
    require("notify").setup({
        background_colour = "#000000",
    }),
}
