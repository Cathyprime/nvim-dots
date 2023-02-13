vim.cmd("syntax enable")
vim.cmd("let g:vimtex_view_method = 'zathura'")
vim.cmd("let maplocalleader = ';'")

return {
  "lervag/vimtex",
  ft = "tex",
}
