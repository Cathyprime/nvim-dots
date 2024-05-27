---@alias id integer @id of the extmark
---@alias line integer @line number of the extmark
---@alias column integer @column number of the extmark

---@class extmark
---@field [1] id @id of the extmark
---@field [2] line @line number of the extmark
---@field [3] column @column number of the extmark
---@field [4]? any[] @optional data associated with the extmark

---@type integer
local ns = vim.api.nvim_create_namespace("cathy_track")

---@return integer lnum line number of cursor
---@return integer col column number of cursor
local function getcurpos()
    local curpos = vim.fn.getpos(".")
    return curpos[2], curpos[3]
end

vim.api.nvim_set_hl(0, "CathyTrack", {
    nocombine = true,
    fg = "#00C000",
})

---@param old? string
---@param cb? fun(): nil
local function mark(old, cb)
    vim.ui.input({ prompt = "Description: ", default = old or "" }, function(desc)
        if cb ~= nil then
            cb()
        end
        local line = getcurpos()
        vim.api.nvim_buf_set_extmark(0, ns, line - 1, 0, {
            virt_text = {
                { desc, "CathyTrack" }
            },
            virt_text_pos = "eol",
        })
    end)
end

local function clear()
    vim.iter(vim.api.nvim_buf_get_extmarks(0, ns, 0, -1, { type = "virt_text" }))
        :each(function(m)
            vim.api.nvim_buf_del_extmark(0, ns, m[1])
        end)
end

---@param details? boolean extmark details toggle
---@return extmark?
local function curmarker(details)
    local line = getcurpos()
    return vim.iter(vim.api.nvim_buf_get_extmarks(0, ns, 0, -1, { type = "virt_text", details = details }))
        :find(function(m)
            return m[2] == line - 1
        end)
end

local function edit()
    local marker = curmarker(true)
    if marker == nil then
        return
    end
    mark(marker[4]["virt_text"][1][1], function()
        vim.api.nvim_buf_del_extmark(0, ns, marker[1])
    end)
end

local function unmark()
    local marker = curmarker()
    if marker == nil then
        return
    end
    vim.api.nvim_buf_del_extmark(0, ns, marker[1])
end

local function toggle()
    local marker = curmarker()
    if marker == nil then
        mark()
    else
        unmark()
    end
end

---@param buf integer
---@param details boolean
---@return extmark[]
local function get_marks(buf, details)
    return vim.api.nvim_buf_get_extmarks(buf, ns, 0, -1, {
        details = details
    })
end

local function get_buffers()
    return vim.iter(vim.api.nvim_list_bufs()):map(function(bufnr)
        return { vim.fn.bufname(bufnr), bufnr }
    end):fold({}, function(acc, buf)
        acc[buf[1]] = acc[2]
        return acc
    end)
end

local function make_label(marker)
    return string.format("[%s] %s | %s:%s", marker.id, marker.desc, marker.file, marker.lnum + 2)
end

local function search(opts)
    local buffers = vim.iter(vim.api.nvim_list_bufs())
        :filter(function(buf)
            return vim.api.nvim_buf_is_loaded(buf)
        end)

    local marks = buffers
        :map(function(buf)
            return vim.iter(get_marks(buf, true)):map(function(marker)
                table.insert(marker, 1, buf)
                return marker
            end):totable()
        end)
        :flatten()
        :filter(function(t)
            return not vim.tbl_isempty(t)
        end)
        :map(function(marker)
            return {
                bufnr = marker[1],
                file = vim.fn.bufname(marker[1]),
                id = marker[2],
                lnum = marker[3] - 1,
                col = marker[4],
                details = marker[5],
                desc = marker[5]["virt_text"][1][1],
            }
        end)
        :totable()

    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local previewers = require("telescope.previewers")
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
    local winnr = vim.api.nvim_get_current_win()
    opts = opts or {}

    pickers
    .new(opts, {
        prompt_title = "annotations",
        finder = finders.new_table(vim.iter(marks):map(make_label):totable()),
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr)
            actions.select_default:replace(function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)

                local target_mark = vim.iter(marks):find(function(marker)
                    return make_label(marker) == selection[1]
                end)
                if not target_mark then
                    return
                end

                local bufs = get_buffers()
                if bufs[target_mark.file] then
                    vim.api.nvim_win_set_buf(winnr, bufs[target_mark.file])
                else
                    vim.cmd("e " .. target_mark.file)
                end
                vim.api.nvim_win_set_cursor(winnr, {
                    target_mark.lnum + 2,
                    0,
                })
            end)
            return true
        end,
        previewer = previewers.new_buffer_previewer({
            define_preview = function(self, entry)
                local target_mark = vim.iter(marks):find(function(marker)
                    return make_label(marker) == entry[1]
                end)
                if not target_mark then
                    return
                end

                local height = vim.api.nvim_win_get_height(self.state.winid)
                local offset = math.floor(height / 2)
                local start_line = target_mark.lnum + 1 - offset
                if start_line < 0 then
                    start_line = 0
                end
                local end_line = start_line + height
                local lines = vim.fn.readfile(target_mark.file)
                lines = vim.iter(lines):enumerate():filter(function(i)
                    return i >= start_line and i <= end_line
                end):fold({}, function(acc, _, el)
                    table.insert(acc, el)
                    return acc
                end)

                local filetype = vim.filetype.match({ filename = target_mark.file })
                vim.api.nvim_set_option_value("filetype", filetype, {
                    buf = self.state.bufnr
                })
                vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
                vim.api.nvim_buf_add_highlight(
                    self.state.bufnr,
                    0,
                    "TelescopeSelection",
                    target_mark.lnum + 1 - start_line,
                    0,
                    -1
                )
            end
        })
    }):find()

end

return {
    mark = mark,
    clear = clear,
    edit = edit,
    unmark = unmark,
    toggle = toggle,
    search = search,
}
