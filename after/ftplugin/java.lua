local ok, jdtls = pcall(require, "jdtls")
if ok then
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
            local client = vim.lsp.get_client_by_id(event.data.client_id)
            require("cathy.config.lsp-funcs").on_attach(client, event.buf)

            local function map(opts)
                vim.keymap.set(opts.mode, "<leader>c" .. opts.lhs, opts.rhs, { buffer = event.buf })
            end
            map({
                mode = "n",
                lhs = "ev",
                ---@diagnostic disable-next-line
                rhs = function() jdtls.extract_variable() end
            })
            map({
                mode = "v",
                lhs = "ev",
                ---@diagnostic disable-next-line
                rhs = function() jdtls.extract_variable({ visual = true }) end
            })
            map({
                mode = "n",
                lhs = "ec",
                ---@diagnostic disable-next-line
                rhs = function() jdtls.extract_constant() end
            })
            map({
                mode = "v",
                lhs = "ec",
                ---@diagnostic disable-next-line
                rhs = function() jdtls.extract_constant({ visual = true }) end
            })
            map({
                mode = "v",
                lhs = "em",
                ---@diagnostic disable-next-line
                rhs = function() jdtls.extract_method({ visual = true }) end
            })
        end
    })

    ---@diagnostic disable-next-line
    jdtls.start_or_attach({
        cmd = { require("mason-core.path").bin_prefix() .. "/jdtls" },
        root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
    })
end
