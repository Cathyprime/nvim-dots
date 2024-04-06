vim.cmd"compiler cargo"
vim.b["dispatch"] = "rustc %"
vim.opt_local.expandtab = true
vim.opt_local.include = [[\\v^\\s*(pub\\s+)?use\\s+\\zs(\\f\|:)+]]
