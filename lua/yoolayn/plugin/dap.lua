return {
    "mfussenegger/nvim-dap",
    event = "VimEnter",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "jay-babu/mason-nvim-dap.nvim",
        "leoluz/nvim-dap-go",
        "mfussenegger/nvim-dap-python",
    },
    config = function()
        require("yoolayn.config.dap")
    end,
}
