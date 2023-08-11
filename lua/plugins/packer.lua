vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use({'wbthomason/packer.nvim'})

    -- telescope stuff
    use({ 'nvim-telescope/telescope.nvim', tag = '0.1.2',
        requires = { {'nvim-lua/plenary.nvim'} } })

    use({"rebelot/kanagawa.nvim",
        config = function()
            require("kanagawa").setup({
            transparent = true,
            overrides = function(colors)
                local theme = colors.theme
                return {
                    TelescopeTitle = { fg = theme.ui.special, bold = true },
                    TelescopePromptNormal = { bg = theme.ui.bg_p1 },
                    TelescopePromptBorder = {
                        fg = theme.ui.bg_p1,
                        bg = theme.ui.bg_p1,
                    },
                    TelescopeResultsNormal = {
                        fg = theme.ui.fg_dim,
                        bg = theme.ui.bg_m1,
                    },
                    TelescopeResultsBorder = {
                        fg = theme.ui.bg_m1,
                        bg = theme.ui.bg_m1,
                    },
                    TelescopePreviewNormal = { bg = theme.ui.bg_dim },
                    TelescopePreviewBorder = {
                        bg = theme.ui.bg_dim,
                        fg = theme.ui.bg_dim,
                    },
                }
            end,
        })
        vim.cmd("colorscheme kanagawa-wave")
        end
        })

    -- treesitter stuff
    use({"nvim-treesitter/nvim-treesitter",
        { run = ":TSUpdate" }})

    use({"nvim-treesitter/nvim-treesitter-textobjects",
        requires = {"nvim-treesitter/nvim-treesitter"},
        after = "nvim-treesitter", })

    use({"JoosepAlviste/nvim-ts-context-commentstring",
        requires = {"nvim-treesitter/nvim-treesitter"},
        after = "nvim-treesitter", })

    use({ "nvim-treesitter/nvim-treesitter-context",
        requires = {"nvim-treesitter/nvim-treesitter"},
        after = "nvim-treesitter",
        config = function() require("treesitter-context").setup() end })

    -- helpers for editing
    use({"numToStr/Comment.nvim",
        config = function() require('Comment').setup() end })

    use({"kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function() require("nvim-surround").setup() end })

    use({"echasnovski/mini.pairs",
        config = function() require("mini.pairs").setup() end })

    use({"mbbill/undotree"})
    use({"anuvyklack/hydra.nvim"})

    -- file navigations
    use({"ThePrimeagen/harpoon"})
    use({"stevearc/oil.nvim"})

    -- git
    use({ "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                on_attach = function(bufnr)
                    local function map(mode, lhs, rhs, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, lhs, rhs, opts)
                    end
                    -- stylua: ignore
                    map({"o", "x"}, "ih", ":<C-u>Gitsigns select_hunk<cr>", {desc = "hunk"})
                end,
            })
        end})
    use({"tpope/vim-fugitive"})

    -- lsp
    use({"VonHeikemen/lsp-zero.nvim",
        branch = "v2.x",
        requires = {
            -- LSP Support
            {"neovim/nvim-lspconfig"},             -- Required
            {"williamboman/mason.nvim"},           -- Optional
            {"williamboman/mason-lspconfig.nvim"}, -- Optional

            -- Autocompletion
            {"hrsh7th/nvim-cmp"},     -- Required
            {"hrsh7th/cmp-nvim-lsp"}, -- Required
            {"L3MON4D3/LuaSnip"},     -- Required
            {"rafamadriz/friendly-snippets",
            config = function () require("luasnip.loaders.from_vscode").lazy_load() end},
            {"hrsh7th/cmp-path"},
            {"saadparwaiz1/cmp_luasnip"},
            {"dgagn/diagflow.nvim",
            config = function () require("diagflow").setup({ scope = "line", }) end }}
        })

    use({"folke/neodev.nvim",
        config = function () require("neodev").setup() end })
end)
