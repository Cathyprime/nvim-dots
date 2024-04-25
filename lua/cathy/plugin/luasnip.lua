vim.api.nvim_create_autocmd("InsertEnter", {
    once = true,
    callback = function()
        require("cathy.config.luasnip")
    end,
})
