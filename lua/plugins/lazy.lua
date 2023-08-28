local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        install = {
            missing = false,
        },
        checker = {
            enabled = false,
        },
        change_detection = {
            notify = false
        },
        { import = "plugins.after" },
        -- telescope stuff
        {
            'nvim-telescope/telescope.nvim',
            tag = '0.1.2',
            dependencies = { { 'nvim-lua/plenary.nvim' } },
        },

        -- colorscheme
        {
            "rebelot/kanagawa.nvim",
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
            end,
        },

        -- helpers for editing
        { "numToStr/Comment.nvim", config = function() require('Comment').setup() end, keys = { "gc", "gcA", {"gc", mode="v"} } },
        {
            "kylechui/nvim-surround",
            tag = "*",
            keys = {"ys", "cs", "ds", {"S", mode = "v"}},
            config = function() require("nvim-surround").setup() end,
        },
        {
            "echasnovski/mini.pairs",
            config = function() require("mini.pairs").setup() end,
        },
        {"mbbill/undotree",
            keys = { { "<leader>u", ":UndotreeToggle<cr>", { silent = true, desc = "toggle undotree" } } } },
        {"anuvyklack/hydra.nvim"},

        -- file management
        {"ThePrimeagen/harpoon"},
        {"nvim-tree/nvim-tree.lua",
            dependencies = {"nvim-tree/nvim-web-devicons"},
            opts = { filters = { dotfiles = true } },
            keys = { { "<leader>e", ":NvimTreeToggle<cr>", {silent = true}} }, },

        -- git integration
        {"tpope/vim-fugitive"},
        {"lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                on_attach = function(bufnr)
                    vim.keymap.set({"o", "x"}, "ih", ":<C-u>Gitsigns select_hunk<cr>", {desc = "inner hunk", buffer = bufnr})
                end,
            })
        end},

        -- lsp
        {"VonHeikemen/lsp-zero.nvim",
            branch = "v2.x",
            dependencies = {
                -- LSP Support
                {"neovim/nvim-lspconfig"},             -- Required
                {"williamboman/mason.nvim"},           -- Optional
                {"williamboman/mason-lspconfig.nvim"}, -- Optional

                -- Autocompletion
                {"hrsh7th/nvim-cmp"},     -- Required
                {"hrsh7th/cmp-nvim-lsp"}, -- Required
                {"L3MON4D3/LuaSnip"},     -- Required
                {"hrsh7th/cmp-buffer"},
                {"octaltree/cmp-look"},
                {"rafamadriz/friendly-snippets",
                    config = function () require("luasnip.loaders.from_vscode").lazy_load() end},
                {"hrsh7th/cmp-path"},
                {"saadparwaiz1/cmp_luasnip"},
                {"dgagn/diagflow.nvim", config = function () require("diagflow").setup({ scope = "line", }) end }
            }
        },
        { "folke/neodev.nvim", config = function () require("neodev").setup() end, ft = "lua" },
        {'j-hui/fidget.nvim', tag = 'legacy',
        config = function() require("fidget").setup({
            text = { spinner = "moon" },
            window = { blend = 0 } })
        end},

        -- ui
        {"JellyApple102/easyread.nvim",
            config = function ()
                require("easyread").setup({ filetypes = {} })
                vim.keymap.set("n", "<leader>U", ":EasyreadToggle<cr>", { desc = "toggle easier reading", silent = true })
            end
        },
        {"folke/todo-comments.nvim",
            dependencies = { "nvim-lua/plenary.nvim" },
            opts = {},
            event = "VimEnter",
        },

        -- lispy stuff (love lisp btw)
        {"eraserhd/parinfer-rust",
            build = "cargo build --release",
            ft = { "lisp", "yuck" }},
        {"elkowar/yuck.vim",
            ft = "yuck"},

        -- misc
        {"ThePrimeagen/vim-be-good"},
        {"tpope/vim-dispatch"},
        {"godlygeek/tabular"},
    }
})
