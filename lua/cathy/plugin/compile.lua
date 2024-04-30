require("mini.deps").add("tpope/vim-dispatch")

require("mini.deps").later(function()
    local function Dispatch_wrapper()
        vim.b["dispatch_ready"] = true
        if vim.b.dispatch then
            return ":Dispatch!<cr>"
        end
        local ok, c = pcall(vim.fn.input, {
            prompt = ":Compile command ",
            default = vim.b.dispatch or "",
            cancelreturn = -99,
            completion = "custom,v:lua.CustomFilesystemCompletion"
        })
        if c == -99 or not ok then return "" end
        vim.cmd("redraw")
        vim.b["dispatch"] = c
        return ":Dispatch!<cr>"
    end

    local function Dispatch_wrapper_change()
        vim.b["dispatch_ready"] = true
        if not vim.b.dispatch then
            return Dispatch_wrapper()
        end
        local ok, c = pcall(vim.fn.input, {
            prompt = ":Compile command ",
            default = vim.b.dispatch or "",
            cancelreturn = -99,
            completion = "custom,v:lua.CustomFilesystemCompletion"
        })
        if not ok or c == -99 then
            return ""
        end
        vim.cmd("redraw")
        vim.b["dispatch"] = c
        return ":Dispatch!<cr>"
    end

    local function make_wrapper()
        vim.b["dispatch_ready"] = true
        local ok, c = pcall(vim.fn.input, {
            prompt = ":make ",
            default = vim.b.dispatch or "",
            cancelreturn = -99,
        })
        vim.cmd("redraw")
        if not ok or c == -99 then return "" end
        return ":Make! " .. c .. "<cr>"
    end
    local function openqf()
        if vim.b.dispatch_ready then
            vim.b["dispatch_ready"] = false
            return "<cmd>botright Cope<cr>"
        else
            return "<cmd>botright cope<cr>"
        end
    end
    vim.keymap.set("n", "ZS",        ":Start ",               { silent = false                })
    vim.keymap.set("n", "Zf",        ":Focus ",               { silent = false                })
    vim.keymap.set("n", "ZF",        ":Focus!<cr>",           { silent = true                 })
    vim.keymap.set("n", "ZD",        Dispatch_wrapper_change, { expr = true, silent = false   })
    vim.keymap.set("n", "Zd",        Dispatch_wrapper,        { expr = true, silent = false   })
    vim.keymap.set("n", "ZM",        make_wrapper,            { expr = true, silent = false   })
    vim.keymap.set("n", "<leader>q", openqf,                  { expr = true, silent = true    })
end)
