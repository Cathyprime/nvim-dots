if not SWITCHES.java then
    return
end

local add = require("mini.deps").add

add({
    source = "mfussenegger/nvim-jdtls",
    depends = {
        'nvim-java/lua-async-await',
        'nvim-java/nvim-java-core',
        'nvim-java/nvim-java-test',
        'nvim-java/nvim-java-dap',
        'MunifTanjim/nui.nvim',
        'neovim/nvim-lspconfig',
        'mfussenegger/nvim-dap',
    }
})
