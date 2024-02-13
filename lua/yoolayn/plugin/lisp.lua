require("mini.deps").add("julienvincent/nvim-paredit")

vim.api.nvim_create_autocmd("filetype", {
    once = false,
    group = vim.api.nvim_create_augroup("lisp", { clear = true }),
    pattern = { "clojure", "lisp", "fennel" },
    callback = function()
        require("nvim-paredit").setup()
    end
})
