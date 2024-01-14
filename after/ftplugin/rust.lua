vim.cmd"compiler cargo"
vim.b["dispatch"] = "rustc %"
vim.opt_local.expandtab = true
vim.opt_local.include = [[\\v^\\s*(pub\\s+)?use\\s+\\zs(\\f\|:)+]]
-- vim.opt_local.listchars:remove "leadmultispace"
-- vim.opt_local.listchars:append [[tab:\u00bb\u0020]]
