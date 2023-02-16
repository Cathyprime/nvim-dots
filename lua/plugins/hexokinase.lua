vim.cmd("let g:Hexokinase_highlighters = ['foreground']")
return {
    "RRethy/vim-hexokinase",
    ft = { "css", "norg" },
    build = "make hexokinase",
    -- enabled = false,
}
