vim.api.nvim_create_autocmd("TermOpen", {
    callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        local map = require("cathy.utils").map_gen({ buffer = bufnr, silent = true })
        map("t", "<esc><esc>", [[<c-\><c-n>]])
        map("t", "<m-w>", [[<c-\><c-n><c-w>w]])
    end,
})
