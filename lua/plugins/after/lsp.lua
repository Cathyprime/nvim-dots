local lsp = require('lsp-zero').preset({})

-- keybinds
lsp.on_attach(function(_, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp.default_keymaps({buffer = bufnr})
    vim.keymap.set("n", "<leader>cn", function() vim.lsp.buf.rename() end, { buffer = bufnr, desc = "rename variable"})
    vim.keymap.set("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>", {buffer = true})
    vim.keymap.set("i", "<c-h>", function() vim.lsp.buf.signature_help() end, {buffer = bufnr, desc = "show signature"})
end)

-- required servers
lsp.ensure_installed({
    "jsonls",
    "lua_ls",
    "pylsp",
    "rust_analyzer",
    "tailwindcss",
    "tsserver",
    "yamlls",
})

-- cmp
local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_action = require('lsp-zero').cmp_action()

---@diagnostic disable-next-line
cmp.setup({
    sources = {
        {name = "luasnip"},
        {name = "nvim_lsp"},
        {name = "path"},
    },
    mapping = {
        ["<c-j>"] = cmp.mapping.select_next_item(cmp_select),
        ["<c-k>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<cr>"] = cmp.mapping.confirm({ select = true}),
        ["<c-space>"] = cmp.mapping.complete(),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<tab>"] = cmp_action.luasnip_jump_forward(),
        ["<s-tab>"] = cmp_action.luasnip_jump_backward(),
    },
})

-- server setups
require("lspconfig").tsserver.setup({
    settings = {
        typescript = {
            format = {
                indentSize = vim.o.shiftwidth,
                convertTabsToSpaces = vim.o.expandtab,
                tabSize = vim.o.tabstop,
            },
        },
        javascript = {
            format = {
                indentSize = vim.o.shiftwidth,
                convertTabsToSpaces = vim.o.expandtab,
                tabSize = vim.o.tabstop,
            },
        },
        completions = {
            completeFunctionCalls = true,
        },
    }
})

require("lspconfig").tailwindcss.setup({
    filetypes_exclude = { "markdown" },
})

require("lspconfig").rust_analyzer.setup({
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                runBuildScripts = true,
            },
            -- Add clippy lints for Rust.
            checkOnSave = {
                allFeatures = true,
                command = "clippy",
                extraArgs = { "--no-deps" },
            },
            procMacro = {
                enable = true,
                ignored = {
                    ["async-trait"] = { "async_trait" },
                    ["napi-derive"] = { "napi" },
                    ["async-recursion"] = { "async_recursion" },
                },
            },
        },
    }
})

lsp.setup()
