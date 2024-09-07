vim.cmd[[set commentstring=//%s]]
vim.b["alt_lsp_maps"] = {
    definition = require("omnisharp_extended").lsp_definition,
}
