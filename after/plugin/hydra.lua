local Hydra = require("hydra")

Hydra({
    name = "Side scroll",
    mode = "n",
    body = "z",
    heads = {
        { "h", "5zh" },
        { "l", "5zl", { desc = "←/→" } },
        { "H", "zH" },
        { "L", "zL", { desc = "half screen ←/→" } },
    },
})

Hydra({
    name = "resize window",
    mode = "n",
    body = "<C-w>",
    heads = {
        { "<", "<C-w><" },
        { ">", "<C-w>>", { desc = "width" } },
        { "+", "<C-w>+" },
        { "-", "<C-w>-", { desc = "height" } },
        { "=", "<C-w>=", { desc = "reset" } },
    },
})

---@type number
local scroll

vim.api.nvim_create_autocmd("BufEnter", {
    once = true,
    callback = function()
        scroll = vim.o.scrolloff
        print(scroll)
    end,
})

local function scrolloff_toggle()
    if vim.o.scrolloff == 0 then
        vim.opt["scrolloff"] = scroll
    else
        vim.o.scrolloff = 0
    end
end

local function boolean_switch(option)
    return function()
        if vim.o[option] == true then
            vim.o[option] = false
        else
            vim.o[option] = true
        end
    end
end

local function virtual_edit()
    if vim.o.virtualedit == "" then
        vim.o.virtualedit = "all"
    else
        vim.o.virtualedit = ""
    end
end

Hydra({
    name = "Options",
    hint = [[
  ^ ^        Options
  ^
  _v_ %{ve} virtual edit
  _i_ %{list} invisible characters
  _s_ %{scrolloff} scrolloff
  _S_ %{spell} spell
  _w_ %{wrap} wrap
  _c_ %{cul} cursor line
  _n_ %{nu} number
  _r_ %{rnu} relative number
  ^
       ^^^^                _<Esc>_
]],
    config = {
        color = "amaranth",
        invoke_on_body = true,
        hint = {
            position = "middle",
            float_opts = {
                border = "rounded",
            },
            funcs = {
                ["scrolloff"] = function()
                    if vim.o.scrolloff == 0 then
                        return "[ ]"
                    else
                        return "[x]"
                    end
                end,
            },
        },
    },
    mode = { "n", "x" },
    body = "<leader>t",
    heads = {
        { "n", boolean_switch("number"), { desc = "number" } },
        { "r", boolean_switch("relativenumber"), { desc = "relativenumber" } },
        { "i", boolean_switch("list"), { desc = "show invisible" } },
        { "w", boolean_switch("wrap"), { desc = "wrap" } },
        { "c", boolean_switch("cursorline"), { desc = "cursor line" } },
        { "S", boolean_switch("spell"), { desc = "spell" } },
        { "v", virtual_edit, { desc = "virtualedit" } },
        { "s", scrolloff_toggle, { desc = "scrolloff" }, },
        { "<Esc>", nil, { exit = true } },
    },
})
