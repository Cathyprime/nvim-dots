return {
    "neovim/nvim-lspconfig",
    opts = {
        diagnostics = {
            underline = true,
            update_in_insert = false,
            virtual_text = false,
            severity_sort = true,
        },
        inlay_hints = {
            enabled = false,
        },
        capabilities = {},
        autoformat = true,
        format_notify = false,
        format = {
            formatting_options = nil,
            timeout_ms = nil,
        },
        servers = {
            jsonls = {},
            lua_ls = {
                settings = {
                    Lua = {
                        workspace = {
                            checkThirdParty = false,
                        },
                        completion = {
                            callSnippet = "Replace",
                        },
                    },
                },
            },
        },
        setup = {},
    },
}
