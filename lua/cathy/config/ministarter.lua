local starter = require("mini.starter")
local cwd = vim.loop.cwd()

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
        { action = "Telescope oldfiles",   name = "Old_files",  section = "Telescope"  },
        { action = "Telescope git_files",  name = "Git_files",  section = "Telescope"  },
        { action = "Telescope find_files", name = "Find_files", section = "Telescope"  },
        { action = "DepsUpdate",           name = "Update",     section = "Deps"       },
        { action = "DepsClean",            name = "Clean",      section = "Deps"       },
        { action = "DepsSnapLoad",         name = "Load",       section = "Deps"       },
        starter.sections.recent_files(5, true, function(path_str)
            path_str = path_str:sub(#cwd + 1)
            local path = {}
            for component in path_str:gmatch("[^/]+") do
                table.insert(path, component)
            end
            local total = #path
            for idx, part in ipairs(path) do
                if idx == total then
                    table.remove(path, idx)
                    break
                end
                path[idx] = part:sub(1, 3)
            end
            if #path == 0 then
                return ""
            end
            return string.format(" (%s)", table.concat(path, "/"))
        end),
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
        end)(), os.getenv("USER")),
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
