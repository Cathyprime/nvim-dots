return {
    {
        "stevearc/oil.nvim",
        keys = {
            {
                "<leader>e",
                function()
                    require("oil").open()
                end,
                desc = "open files",
            },
        },
        opts = {},
    },
    {
        "nvim-pack/nvim-spectre",
        cmd = "Spectre",
        opts = { open_cmd = "noswapfile vnew" },
		-- stylua: ignore
		keys = {
			{ "<leader>ur", function() require("spectre").open() end, desc = "Replace in files (spectre)" },
		},
    },
}
