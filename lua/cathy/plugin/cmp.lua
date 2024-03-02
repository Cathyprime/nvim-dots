require("mini.deps").add({
    source = "hrsh7th/nvim-cmp",
    depends = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-cmdline",
    }
})

require("mini.deps").later(function()
    require("cathy.config.cmp")
    local colors = require("cathy.config.cmp-colors")
    colors.run(false)
    colors.set_autocmd()
end)
