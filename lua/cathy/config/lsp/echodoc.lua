vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(opts)
        vim.api.nvim_create_autocmd("CursorHold" , {
            buffer = opts.buf,
            callback = function()
                vim.lsp.buf_request(
                    opts.buf,
                    "textDocument/signatureHelp",
                    vim.lsp.util.make_position_params(),
                    function(err, result, crx, config)
                        if result then
                            vim.api.nvim_echo({ { require("lsp_signature").status_line(vim.api.nvim_win_get_width(0)).label, "Normal" } }, false, {})
                        else
                            vim.cmd "mode"
                        end
                    end
                )
            end
        })
    end,
})
