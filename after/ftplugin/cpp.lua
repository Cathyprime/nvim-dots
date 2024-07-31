vim.api.nvim_create_autocmd("BufEnter", {
    once = true,
    callback = function()
        vim.opt.indentkeys:remove(":")
    end
})

vim.opt.expandtab = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
