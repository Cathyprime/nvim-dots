return {
    "mrcjkb/rustaceanvim",
    ft = "rust",
    init = function()
        vim.g.rustaceanvim = {
            dap = {
                disable = true
            },
            tools = {
                float_win_config = {
                    border = "single",
                },
            },
            server = {
                on_attach = function(client, bufnr)
                    require("cathy.config.lsp-funcs").on_attach(client, bufnr, {
                        code_action = function()
                            vim.cmd.RustLsp("codeAction")
                        end,
                        hover = function()
                            vim.cmd.RustLsp({ "hover", "actions" })
                        end,
                    })
                end,
            },
        }
    end
}
