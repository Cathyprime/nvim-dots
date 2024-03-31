vim.api.nvim_create_autocmd("BufEnter", {
    once = true,
    callback = function()
        vim.opt.indentkeys:remove(":")
    end
})
