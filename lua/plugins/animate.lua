return {
    "echasnovski/mini.animate",
    require("mini.animate").setup({
        cursor = {
            enable = true,
            timing = require("mini.animate").gen_timing.linear({ duration = 100, unit = "total" }),
        },
        scroll = {
            enable = true,
            timing = require("mini.animate").gen_timing.linear({ duration = 100, unit = "total" }),
        },
    }),
}
