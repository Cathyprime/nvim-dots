vim.g.rustaceanvim = {
    server = { on_attach = function(client, bufnr)
            require("cathy.config.lsp-funcs").on_attach(client, bufnr, {
                code_action = function()
                    vim.cmd.RustLsp("codeAction")
                end,
                hover = function()
                    vim.cmd.RustLsp({"hover", "range"})
                    vim.cmd.RustLsp({"hover", "actions"})
                end
            })
        end
    }
}

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile", "BufEnterPre" }, {
    once = true,
    pattern = "*.rs",
    group = vim.api.nvim_create_augroup("cathy_rust", { clear = true }),
    callback = function()
        vim.cmd.packadd("rustaceanvim")
    end,
})
