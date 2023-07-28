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
    name = "Change window",
    mode = "n",
    body = "<C-w>",
    heads = {
        { "h", "<C-w>h" },
        { "j", "<C-w>j" },
        { "k", "<C-w>k" },
        { "l", "<C-w>l" },
    },
    config = {
        timout = 500,
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
