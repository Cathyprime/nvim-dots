-- :Slop -- the sloppiest, yet fully functional, command in the config.
-- Serves artisanal slop into the current buffer (or messages if no buffer).

local slop = {
    "glorp noodles in the sauce lagoon",
    "goblin gravy, extra goblin",
    "wet crumbs with luxurious cheese fog",
    "a barrel of pudding foam",
    "nine syrup bricks",
    "one tall glass of melted snack",
    "crunchlet medley (maybe)",
    "butter clouds over a fried mush plateau",
    "a biscuit drowned in pan juice",
    "cream avalanche, hold the restraint",
}

local function ladle(count)
    local lines = {}
    for _ = 1, count do
        lines[#lines + 1] = "🍲 " .. slop[math.random(#slop)]
    end
    return lines
end

vim.api.nvim_create_user_command(
    "Slop",
    function(opts)
        local count = tonumber(opts.args) or 1
        if count < 1 then
            count = 1
        end
        local lines = ladle(count)

        if opts.bang or vim.bo.buftype ~= "" or not vim.bo.modifiable then
            vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO)
            return
        end

        local row = vim.api.nvim_win_get_cursor(0)[1]
        vim.api.nvim_buf_set_lines(0, row, row, false, lines)
    end,
    {
        bang = true,
        nargs = "?",
        desc = "Serve some slop (:Slop [count], :Slop! to message instead)",
    }
)
