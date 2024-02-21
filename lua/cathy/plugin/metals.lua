require("mini.deps").add({
    source = "scalameta/nvim-metals",
    depends = {
        "nvim-lua/plenary.nvim",
    }
})

require("mini.deps").later(function()
    local metals = require("metals")
    local metals_config = metals.bare_config()
    metals_config.settings = {
        showImplicitArguments = true,
    }
    metals_config.init_options.statusBarProvider = "on"
    metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

    vim.keymap.set("n", "<leader>lmc", function()
        require("telescope").extensions.metals.commands()
    end)

    local nvim_metals_group = vim.api.nvim_create_augroup("metals", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "scala", "sbt", "java" },
        callback = function()
            metals.initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group,
    })
end)
