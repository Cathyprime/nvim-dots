vim.cmd.packadd("go.nvim")
vim.opt_local.expandtab = false
vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.api.nvim_create_autocmd("BufEnter", {
    once = true,
    callback = function()
        vim.opt.indentkeys:remove("<:>")
        vim.opt_local.formatoptions:append("ro")
    end
})

if not SWITCHES.go then
    return
end

local ok, go = pcall(require, "go")
if ok then
    go.setup({
        dap_debug = true,
        lsp_codelens = false,
    })
    local o, d = pcall(require, "dap-go")
    if o then
        d.setup()
    end
end
