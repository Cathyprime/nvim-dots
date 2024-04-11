local starter = require("mini.starter")
local utils = require("util.telescope-utils")

local config = {
    content_hooks = {
        starter.gen_hook.adding_bullet(""),
        starter.gen_hook.aligning("center", "center"),
    },
    evaluate_single = true,
    header = "",
    footer = "",
    query_updaters = [[abcdefghijklmnopqrstuvwxyz0123456789_-,.ABCDEFGHIJKLMNOPQRSTUVWXYZ]],
    items = {
        { action = "Telescope oldfiles",   name = "Old files",  section = "Telescope" },
        { action = "Telescope git_files",  name = "Git files",  section = "Telescope" },
        { action = "Telescope find_files", name = "Find files", section = "Telescope" },
        { action = utils.get_nvim,         name = "Init Files", section = "Telescope" },
        { action = "Neogit",               name = "Neogit",     section = "Neogit"    },
        { action = "DepsUpdate",           name = "Update",     section = "Plugins"   },
        { action = "DepsClean",            name = "Clean",      section = "Plugins"   },
        { action = "DepsSnapLoad",         name = "Load",       section = "Plugins"   },
        { action = "Rocks sync",           name = "Sync",       section = "Plugins"   },
        { action = "Rocks edit",           name = "Edit",       section = "Plugins"   },
        starter.sections.builtin_actions(),
    },
}

(function()
    local header = {
        "NEOVIM",
        tostring(vim.version()),
        "",
        string.format("%s, %s", (function()
            local time = os.date("*t")
            if time.hour > 20 or time.hour < 5 then
                return "Good Evening"
            elseif time.hour < 12 then
                return "Good Morning"
            end
            return "haaiii :3"
        end)(), os.getenv("USER"):gsub("^%l", string.upper)),
        "How are you doing?",
        os.date()
    }
    local longest
    for _, content in ipairs(header) do
        longest = math.max(#content, longest or 0)
    end
    for idx, content in ipairs(header) do
        if content == "" then goto continue end
        local len_diff = longest - #content
        local pad = math.floor(len_diff / 2)
        header[idx] = string.format(
            "%s%s",
            string.rep(" ", pad),
            content
        )
        ::continue::
    end
    config.footer = table.remove(header, #header)
    config.header = table.concat(header, "\n")
end)()

return config
