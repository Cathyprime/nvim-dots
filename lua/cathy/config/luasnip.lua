local ls = require "luasnip"

vim.keymap.set({"i"}, "<c-x>l", function() ls.expand() end, {silent = true})
vim.keymap.set({"i", "s"}, "<c-j>", function() ls.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<c-k>", function() ls.jump(-1) end, {silent = true})

vim.keymap.set({"i", "s"}, "<c-l>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end, {silent = true})

local types = require("luasnip.util.types")

ls.config.setup({
    history = true,
    update_events = {"TextChanged", "TextChangedI"},
    enable_autosnippets = true,
    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = {{"●", "PortalOrange"}},
                hl_mode = "combine"
            }
        },
        [types.insertNode] = {
            active = {
                virt_text = {{"●", "PortalBlue"}},
                hl_mode = "combine"
            }
        }
    },
})

require("luasnip.loaders.from_lua").lazy_load({paths = "./lua/cathy/snippets"})
