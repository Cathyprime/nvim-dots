return {
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                on_attach = function(bufnr)
                    local function map(mode, lhs, rhs, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, lhs, rhs, opts)
                    end
                    -- stylua: ignore
                    map({"o", "x"}, "ih", ":<C-u>Gitsigns select_hunk", {desc = "hunk"})
                end,
            })
        end,
    },
    {
        "tpope/vim-fugitive",
    },
    {
        "NeogitOrg/neogit",
        dependencies = "nvim-lua/plenary.nvim",
        opts = {
            disable_signs = true,
        },
        keys = {
            {
                "<leader>gg",
                "<cmd>Neogit<cr>",
                desc = "Open Neogit",
            },
        },
    },
}
