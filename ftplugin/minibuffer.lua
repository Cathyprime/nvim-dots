vim.keymap.set(
    {"n", "i"},
    "<c-g>",
    function()
        vim.api.nvim_win_close(0, false)
        return "<esc>"
    end,
    { expr = true, buffer = true, silent = true }
)

local function map(modes, lhs, rhs)
    vim.keymap.set(modes, lhs, rhs, { buffer = true, silent = true })
end

map({"n", "i"}, "<c-c>",    "<esc><c-w>c")
map("i"       , "<c-k>",           "<up>")
map("i"       , "<c-j>",         "<down>")
map("i"       , "<c-e>",          "<end>")
map("i"       , "<c-a>",         "<home>")
map("n"       , "<esc>", "<cmd>close<cr>")
map("n"       , "<c-p>",          "<nop>")

vim.api.nvim_win_set_height(0, 2)
vim.opt_local.spell = false
vim.opt_local.winbar = nil
vim.opt_global.laststatus = 0
vim.opt_local.number = false
vim.opt_local.relativenumber = false
vim.opt_local.scrolloff = 0
vim.opt_local.completeopt = "menu"
vim.opt.cmdheight = 0

vim.api.nvim_create_autocmd("CmdwinLeave", {
    buffer = vim.api.nvim_get_current_buf(),
    once = true,
    callback = function()
        vim.o.laststatus = 3
        vim.opt.cmdheight = 1
    end
})

vim.api.nvim_win_set_cursor(0, { vim.fn.line('$'), 0 })

local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")
local cmp = require("cmp")
---@diagnostic disable-next-line
cmp.setup.buffer({
    sources = cmp.config.sources({
        { name = "nvim_lua" },
    }),

    mapping = {
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                if #cmp.get_entries() == 1 then
                    cmp.confirm({ select = true })
                else
                    cmp.select_next_item()
                end
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
                if #cmp.get_entries() == 1 then
                    cmp.confirm({ select = true })
                end
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),

    },
})
