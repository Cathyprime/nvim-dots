vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4

if not SWITCHES.scala then
    return
end

vim.cmd.packadd("nvim-metals")
local metals_config = require("metals").bare_config()
metals_config.init_options.statusBarProvider = "on"
metals_config.settings = {
    showImplicitArguments = true,
    excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
}
metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
metals_config.on_attach = function(client, bufnr)
    if SWITCHES.dap then
        require("metals").setup_dap()
        local dap = require("dap")

        dap.configurations.scala = {
            {
                type = "scala",
                request = "launch",
                name = "Run or Test Target",
                metals = {
                    runType = "runOrTestFile",
                },
            },
            {
                type = "scala",
                request = "launch",
                name = "Test Target",
                metals = {
                    runType = "testTarget",
                },
            },
        }
    end
    require("cathy.config.lsp-funcs").on_attach(client, bufnr)
end

vim.api.nvim_create_autocmd("BufEnter", {
    once = true,
    callback = function()
        vim.opt.indentkeys:remove("<>>")
        vim.opt.indentkeys:remove("=case")
    end
})

require("metals").initialize_or_attach(metals_config)
