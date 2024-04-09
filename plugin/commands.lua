vim.api.nvim_create_user_command(
    "Messages",
    [[let output = [] | redir => output | silent messages | redir END | silent cexpr output | silent cope]],
    {}
)

vim.api.nvim_create_user_command(
    "Terminal",
    function(opts)
        vim.cmd(string.format("botright " .. opts.count .. "sp | exec 'term %s' | startinsert", opts.args))
        vim.api.nvim_buf_set_name(0, "Terminal")
        vim.api.nvim_create_autocmd("TermClose", {
            once = true,
            buffer = vim.api.nvim_get_current_buf(),
            command = "bd!"
        })
    end,
    {
        nargs = "*",
        count = 12
    }
)

local function create_command(cmd, argument, desc)
    vim.api.nvim_create_user_command(
        cmd,
        function()
            if vim.fn.executable("spt") ~= 1 then
                vim.notify("spt not found!", vim.log.levels.ERROR)
                return
            end
            vim.system({
                "spt",
                "playback",
                argument,
            })
        end,
        {
            desc = desc,
        }
    )
end

vim.api.nvim_create_user_command(
    "Docker",
    function ()
        if vim.fn.executable("lazydocker") ~= 1 then
            vim.notify("lazydocker not found!", vim.log.levels.ERROR)
            return
        end
        vim.cmd("tabnew | exec 'term lazydocker' | startinsert")
        vim.api.nvim_buf_set_name(0, "LazyDocker")
        vim.api.nvim_create_autocmd("TermClose", {
            once = true,
            buffer = vim.api.nvim_get_current_buf(),
            command = "bd!",
        })
    end,
    {
        desc = "Open lazydocker"
    }
)

vim.api.nvim_create_user_command(
    "Spotify",
    function()
        if vim.fn.executable("spt") ~= 1 then
            vim.notify("spt not found!", vim.log.levels.ERROR)
            return
        end
        vim.cmd("tabnew | exec 'term spt' | startinsert")
        vim.api.nvim_buf_set_name(0, "Spotify")
        vim.api.nvim_create_autocmd("TermClose", {
            once = true,
            buffer = vim.api.nvim_get_current_buf(),
            command = "bd!",
        })
    end,
    {
        desc = "Open spotify"
    }
)

create_command("SpotifyRepeat",  "--repeat",   "toggle repeat mode")
create_command("SpotifyPP",      "--toggle",   "play/pause the music")
create_command("SpotifyLike",    "--like",     "like the current song")
create_command("SpotifyDisLike", "--dislike",  "dislike the current song")
create_command("SpotifyNext",    "--next",     "switch to the next track")
create_command("SpotifyPrev",    "--previous", "switch to the previous track")

vim.api.nvim_create_user_command(
    "Delview",
    function()
        local path = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p")
        if path == nil then
            vim.notify("error getting path", vim.log.levels.ERROR)
            return
        end
        path = vim.fn.substitute(path, "=", "==", "g")
        if path == nil then
            vim.notify("error doubling equal signs", vim.log.levels.ERROR)
            return
        end
        path = vim.fn.substitute(path, "^" .. os.getenv("HOME"), "\\~", "")
        if path == nil then
            vim.notify("substitute error", vim.log.levels.ERROR)
            return
        end
        path = vim.fn.substitute(path, "/", "=+", "g") .. "="
        local file_path = vim.opt.viewdir:get() .. path
        local int = vim.fn.delete(file_path)
        if int == -1 then
            vim.notify("View not found!", vim.log.levels.ERROR)
        else
            vim.notify(string.format("deleted view: %s", file_path), vim.log.levels.INFO)
        end
    end,
    {}
)

vim.api.nvim_create_user_command(
    "Scratch",
    function(opts)
        local ft
        if #opts.fargs ~= 0 then
            local args = opts.fargs[1]
            ft = args
        else
            ft = vim.api.nvim_get_option_value("filetype", {
                buf = 0,
            })
        end
        if not opts.bang then
            vim.cmd(opts.mods .. " split")
        end
        vim.cmd"enew"
        vim.api.nvim_set_option_value("buftype", "nofile", { buf = 0 })
        vim.api.nvim_set_option_value("bufhidden", "hide", { buf = 0 })
        vim.api.nvim_set_option_value("swapfile", false, { buf = 0 })
        if ft == [[nil]] or ft == [[""]] then
            return
        end
        vim.api.nvim_set_option_value("filetype", ft, { buf = 0 })
        if ft == "sh" then
            vim.keymap.set("n", "<cr>", "mm<cmd>.!sh<cr>u`m", { buffer = true })
        else
            vim.cmd("LspStart")
        end
    end,
    {
        bang = true,
        nargs = '?',
        complete = "filetype"
    }
)

local status = true

local old_font = vim.opt.guifont
vim.api.nvim_create_user_command(
    "Presentation",
    function()
        if status then
            vim.opt_global.laststatus = 0
            vim.opt_global.cmdheight = 0
            vim.opt.nu = false
            vim.opt.rnu = false
            status = false
            if vim.g.neovide then
                vim.opt.guifont = "JetBrainsMono NFM:h20"
            else
                vim.fn.system("tmux set -g status off")
            end
        else
            vim.opt_global.laststatus = 3
            vim.opt_global.cmdheight = 1
            status = true
            vim.opt.nu = true
            vim.opt.rnu = true
            if vim.g.neovide then
                vim.opt.guifont = old_font
            else
                vim.fn.system("tmux set -g status off")
            end
        end
    end,
    { nargs = 0 }
)
