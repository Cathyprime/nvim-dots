require("mini.deps").add("skywind3000/asyncrun.vim")

require("mini.deps").later(function()
    vim.g.asyncrun_open = 10
    vim.g.asyncrun_trim = 0

    local function cope(s)
        local split = vim.split(s, " ")
        local found = false
        for _, v in ipairs(split) do
            if v:sub(1, 1) ~= "-" then break end
            if v == "-mode=term" then
                found = true
            end
        end
        if found then
            return
        end
        vim.cmd("cope")
    end

    local function run_wrap(new)
        local compile_cmd = vim.b.compile
        if not new and compile_cmd then
            local cmd = vim.fn.expandcmd(compile_cmd)
            vim.cmd(string.format("AsyncRun -rows=10 %s", cmd))
            cope(compile_cmd or "")
            return
        end
        local ok, c = pcall(vim.fn.input, {
            prompt = "Compile command: ",
            default = compile_cmd or "",
            cancelreturn = -99,
        })
        if not ok or c == -99 then
            if new and c == - 99 then
                vim.b.compile = nil
            end
            return
        end
        vim.cmd("redraw")
        vim.b["compile"] = c
        local cmd = vim.fn.expandcmd(c)
        cope(c or "")
        vim.cmd(string.format("AsyncRun %s", cmd))
    end

    vim.keymap.set("n", "<c-c>d", function() run_wrap(false) end, { silent = false })
    vim.keymap.set("n", "<c-c>D", function() run_wrap(true) end, { silent = false })
    vim.keymap.set("n", "<c-c><c-c>", "<cmd>AsyncStop<cr>")
end)
