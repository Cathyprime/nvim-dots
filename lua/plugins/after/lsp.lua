local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(_, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp.default_keymaps({buffer = bufnr})
    vim.keymap.set("n", "<leader>cn", function() vim.lsp.buf.rename() end, { buffer = bufnr, desc = "rename variable"})
    vim.keymap.set("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>", {buffer = true})
    vim.keymap.set("i", "<c-h>", function() vim.lsp.buf.signature_help() end, {buffer = bufnr, desc = "show signature"})
end)

lsp.ensure_installed({
    "rust_analyzer",
    "tsserver",
    "pylsp",
    "lua_ls",
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_action = require('lsp-zero').cmp_action()

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

lsp.setup()
