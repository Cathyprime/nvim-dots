require("mini.deps").add({
    source = "scalameta/nvim-metals",
    depends = {
        "nvim-lua/plenary.nvim",
    }
})

local metals_config = require("metals").bare_config()
metals_config.init_options.statusBarProvider = "on"
metals_config.settings = {
    showImplicitArguments = true,
    excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
}
metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
metals_config.on_attach = function(client, bufnr)
    if not SWITCHES.dap then
        require("metals").setup_dap()
    end
    require("cathy.config.lsp-funcs").on_attach(client, bufnr)
end

local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "scala", "sbt" },
    callback = function()
        require("metals").initialize_or_attach(metals_config)
    end,
    group = nvim_metals_group,
})
