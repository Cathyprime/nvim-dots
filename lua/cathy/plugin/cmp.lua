require("mini.deps").add({
    source = "hrsh7th/nvim-cmp",
    depends = {
        "hrsh7th/cmp-nvim-lsp",
    }
})

vim.api.nvim_create_autocmd("InsertEnter", {
    once = true,
    callback = function()
        require("cathy.config.cmp")
        local colors = require("cathy.config.cmp-colors")
        colors.run(false)
        colors.set_autocmd()
    end,
})
