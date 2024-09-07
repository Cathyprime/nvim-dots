vim.b["alt_lsp_maps"] = {
    code_action = function()
        vim.cmd.RustLsp("codeAction")
    end,
    hover = function()
        vim.cmd.RustLsp({ "hover", "actions" })
    end,
}

vim.opt_local.expandtab = false
vim.g.termdebugger = "rust-gdb"
