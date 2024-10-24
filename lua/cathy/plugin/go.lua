return {
    "ray-x/go.nvim",
    ft = "go",
    opts = {
        dap_debug = true,
        lsp_codelens = false,
        diagnostic = {
            hdlr = false,
            underline = false,
            virtual_text = false,
            signs = false,
            update_in_insert = false
        }
    },
}
