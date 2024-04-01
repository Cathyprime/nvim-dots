vim.opt_local.expandtab = false
vim.opt_local.shiftwidth = 8
vim.opt_local.tabstop = 8
vim.api.nvim_create_autocmd("BufEnter", {
    once = true,
    callback = function()
        vim.opt.indentkeys:remove("<:>")
        vim.opt_local.formatoptions:append("ro")
    end
})

local ok, go = pcall(require, "go")
if ok then
    go.setup({
        dap_debug = true
    })
    local o, d = pcall(require, "dap-go")
    if o then
        d.setup()
    end
end
