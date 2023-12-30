# Neovim dots

Plugin list in the readme might not be up to date every time :3
## Install Instructions

 > Install requires Neovim 0.10+ (due to the neorg plugin). Always review the code before installing a configuration.

Clone the repository and install the plugins:

```sh
git clone git@github.com:Yoolayn/nvim-dots ~/.config/Yoolayn/nvim-dots
NVIM_APPNAME=Yoolayn/nvim-dots/ nvim --headless +"Lazy! sync" +qa
```

Open Neovim with this config:

```sh
NVIM_APPNAME=Yoolayn/nvim-dots/ nvim
```

## Plugins

### colorscheme
#### main
+ [rebelot/kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim)

#### additional
+ [catppuccin/nvim](https://github.com/catppuccin/nvim)
+ [rose-pine/neovim](https://github.com/rose-pine/neovim)
+ [folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim)
+ [neanias/everforest-nvim](https://github.com/neanias/everforest-nvim)

### UI
+ [stevearc/dressing.nvim](https://github.com/stevearc/dressing.nvim)
+ [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
+ [echasnovski/mini.starter](https://github.com/echasnovski/mini.starter)
+ [echasnovski/mini.indentscope](https://github.com/echasnovski/mini.indentscope)

### Notes
+ [nvim-neorg/neorg](https://github.com/nvim-neorg/neorg)

### completion
+ [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp)

#### sources
+ [hrsh7th/cmp-buffer](https://github.com/hrsh7th/cmp-buffer)
+ [hrsh7th/cmp-cmdline](https://github.com/hrsh7th/cmp-cmdline)
+ [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp)
+ [hrsh7th/cmp-nvim-lua](https://github.com/hrsh7th/cmp-nvim-lua)
+ [hrsh7th/cmp-path](https://github.com/hrsh7th/cmp-path)
+ [hrsh7th/cmp-nvim-lsp-signature-help](https://github.com/hrsh7th/cmp-nvim-lsp-signature-help)

### code editing support
+ [echasnovski/mini.align](https://github.com/echasnovski/mini.align)
+ [echasnovski/mini.operators](https://github.com/echasnovski/mini.operators)
+ [kylechui/nvim-surround](https://github.com/kylechui/nvim-surround)
+ [Wansmer/treesj](https://github.com/Wansmer/treesj)
+ [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs)
+ [numToStr/Comment.nvim](https://github.com/numToStr/Comment.nvim)

### files
+ [stevearc/oil.nvim](https://github.com/stevearc/oil.nvim)
+ [miversen33/netman.nvim](https://github.com/miversen33/netman.nvim)
+ [nvim-neo-tree/neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)

### fuzzy finder
+ [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)

### git
+ [lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
+ [sindrets/diffview.nvim](https://github.com/sindrets/diffview.nvim)
+ [tpope/vim-fugitive](https://github.com/tpope/vim-fugitive)

### keybinding
+ [anuvyklack/hydra.nvim](https://github.com/anuvyklack/hydra.nvim)

### lsp and friends
+ [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
+ [mfussenegger/nvim-lint](https://github.com/mfussenegger/nvim-lint)
+ [scalameta/nvim-metals](https://github.com/scalameta/nvim-metals)
+ [j-hui/fidget.nvim](https://github.com/j-hui/fidget.nvim)
+ [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim)

### debugging
+ [jay-babu/mason-nvim-dap.nvim](https://github.com/jay-babu/mason-nvim-dap.nvim)
+ [mfussenegger/nvim-dap](https://github.com/mfussenegger/nvim-dap)
+ [leoluz/nvim-dap-go](https://github.com/leoluz/nvim-dap-go)
+ [rcarriga/nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui)
+ [mfussenegger/nvim-dap-python](https://github.com/mfussenegger/nvim-dap-python)

### coding tool installer
+ [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim)
+ [WhoIsSethDaniel/mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim)

### nvim-dev
+ [folke/neodev.nvim](https://github.com/folke/neodev.nvim)
+ [KaitlynEthylia/Evalua](https://github.com/KaitlynEthylia/Evalua)
+ [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
+ [milisims/nvim-luaref](https://github.com/milisims/nvim-luaref)

### plugin-manager
+ [folke/lazy.nvim](https://github.com/folke/lazy.nvim)

### programming-languages-support
+ [julienvincent/nvim-paredit](https://github.com/julienvincent/nvim-paredit)

### quickfix
+ [kevinhwang91/nvim-bqf](https://github.com/kevinhwang91/nvim-bqf)

### snippet
+ [L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip)

### treesitter
+ [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
+ [nvim-treesitter/nvim-treesitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects)

### utility
+ [kevinhwang91/nvim-fundo](https://github.com/kevinhwang91/nvim-fundo)
+ [mbbill/undotree](https://github.com/mbbill/undotree)
+ [tpope/vim-eunuch](https://github.com/tpope/vim-eunuch)
+ [dohsimpson/vim-macroeditor](https://github.com/dohsimpson/vim-macroeditor)
+ [dstein64/vim-startuptime](https://github.com/dstein64/vim-startuptime)
