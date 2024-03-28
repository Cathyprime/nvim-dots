vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4

if not SWITCHES.scala then
    return
end

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

require("metals").initialize_or_attach(metals_config)
