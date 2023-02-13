vim.cmd("let g:Hexokinase_highlighters = ['virtual']")
return {
    "RRethy/vim-hexokinase",
    ft = "css",
    build = "make hexokinase",
    -- enabled = false,
}
