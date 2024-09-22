local starter = require("mini.starter")
local utils = require("cathy.utils.telescope")

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
        { action = utils.hidden,           name = "Find files", section = "Telescope" },
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
    local version = vim.version()
    local header = {
        "NEOVIM",
        "v" .. version.major .. "." .. version.minor .. "." .. version.patch,
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
    local longest = vim.iter(header):fold(0, function(acc, value)
        return math.max(#value, acc or 0)
    end)
    header = vim.iter(ipairs(header)):filter(function(value)
        return value ~= ""
    end)
        :fold({}, function(acc, index, value)
        local len_diff = longest - #value
        local pad = math.floor(len_diff / 2)
        acc[index] = string.format(
            "%s%s",
            string.rep(" ", pad),
            value
        )
        return acc
    end)
    config.footer = table.remove(header, #header)
    config.header = table.concat(header, "\n")
end)()

return config
