vim.cmd("let g:Hexokinase_highlighters = ['virtual']")
return {
    "RRethy/vim-hexokinase",
    build = "make hexokinase",
    -- enabled = false,
}
