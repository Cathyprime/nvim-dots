vim.api.nvim_create_autocmd("VimEnter", {
    callback = function ()
        require("todo-comments").setup()
    end
})
