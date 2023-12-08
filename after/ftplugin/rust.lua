vim.cmd"compiler cargo"
vim.b["dispatch"] = "cargo run"

vim.opt_local.include = [[\\v^\\s*(pub\\s+)?use\\s+\\zs(\\f\|:)+]]
