vim.b.dispatch = "python %"
vim.keymap.set("n", "<localleader>r", "<cmd>Dispatch<cr>", { silent = true })
vim.opt_local.listchars:remove([[leadmultispace]])
