require("mini.deps").add({
    source = "scalameta/nvim-metals",
    depends = {
        "nvim-lua/plenary.nvim",
    }
})

local metals = require("metals")
local metals_config = metals.bare_config()
metals_config.settings = {
    showImplicitArguments = true,
    enableSemanticHighlighting = false,
}
metals_config.init_options.statusBarProvider = "on"

vim.keymap.set("n", "<leader>lmc", function()
    require("telescope").extensions.metals.commands()
end)

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "scala", "sbt", "java" },
    callback = function()
        metals.initialize_or_attach(metals_config)
    end,
    group = vim.api.nvim_create_augroup("nvim-metals", { clear = true }),
})
