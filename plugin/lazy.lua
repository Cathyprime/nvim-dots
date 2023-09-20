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
        -- telescope stuff
        {
            'nvim-telescope/telescope.nvim',
            tag = '0.1.2',
            dependencies = { 'nvim-lua/plenary.nvim' },
        },

        -- colorscheme
        "rebelot/kanagawa.nvim",

        -- helpers for editing
        "rstacruz/vim-closer",
        "numToStr/Comment.nvim",
        {
            "kylechui/nvim-surround",
            tag = "*",
        },
        "mbbill/undotree",
        "anuvyklack/hydra.nvim" ,

        -- file management
        "ThePrimeagen/harpoon",

        -- git integration
        "tpope/vim-fugitive",
        "lewis6991/gitsigns.nvim",

        -- treesitter
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            dependencies = {
                "nvim-treesitter/nvim-treesitter-textobjects",
                "JoosepAlviste/nvim-ts-context-commentstring",
                "nvim-treesitter/playground",
            }
        },
        -- lsp
        {
            "VonHeikemen/lsp-zero.nvim",
            branch = "v2.x",
            dependencies = {
                -- LSP Support
                "neovim/nvim-lspconfig",             -- Required
                "williamboman/mason.nvim",           -- Optional
                "williamboman/mason-lspconfig.nvim", -- Optional

                -- Autocompletion
                "hrsh7th/nvim-cmp",     -- Required
                "hrsh7th/cmp-nvim-lsp", -- Required
                "L3MON4D3/LuaSnip",     -- Required
                "hrsh7th/cmp-buffer",
                "octaltree/cmp-look",
                "rafamadriz/friendly-snippets",
                "hrsh7th/cmp-path",
                "saadparwaiz1/cmp_luasnip",
                "dgagn/diagflow.nvim",
            },
        },
        "j-hui/fidget.nvim", tag = 'legacy',
        {
            "scalameta/nvim-metals",
            dependencies = { "nvim-lua/plenary.nvim" },
        },

        -- ui
        "JellyApple102/easyread.nvim",
        {
            "folke/todo-comments.nvim",
            dependencies = { "nvim-lua/plenary.nvim" },
        },

        -- lispy stuff (love lisp btw)
        {"eraserhd/parinfer-rust",
        build = "cargo build --release",
        ft = { "lisp", "yuck" }},
        {"elkowar/yuck.vim",
        ft = "yuck"},

        -- misc
        "ThePrimeagen/vim-be-good",
        "tpope/vim-dispatch",
        "godlygeek/tabular",
        "tpope/vim-eunuch",
 a   }
})
