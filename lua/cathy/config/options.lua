local options = {}

options.options = {
    rnu = true,
    nu = true,
    cpo = {
        append = {
            ">"
        }
    },
    spell = true,
    spl = "en_us,en_gb,pl",
    tabstop = 4,
    shiftwidth = 4,
    smartindent = false,
    autoindent = false,
    expandtab = true,
    exrc = true,
    list = true,
    listchars = {
        append = {
            [[trail:-]],
            [[tab:\u00b7\u0020\u0020]],
            [[precedes:\u2190]],
            [[extends:\u2192]],
            [[leadmultispace:\u00b7]],
            [[nbsp:\u2423]],
        },
    },
    fillchars = {
        append = {
            [[foldclose:>]],
            [[foldopen:v]],
            [[foldsep: ]],
            [[fold: ]],
        },
    },
    linebreak = true,
    showbreak = "-> ",
    path = ".,**",
    ignorecase = true,
    smartcase = true,
    incsearch = true,
    foldlevel = 4,
    formatoptions = {
        remove = {
            "l"
        }
    },
    -- foldexpr = [[getline(v:lnum)=~'^\s*$'?'0':'1']],
    foldexpr = [[v:lua.vim.treesitter.foldexpr()]],
    foldtext = "",
    foldmethod = "expr",
    foldcolumn = "0",
    foldnestmax = 4,
    hls = true,
    cursorline = true,
    guicursor = "i-ci-ve:block",
    showcmdloc = "statusline",
    cmdwinheight = 2,
    showtabline = 0,
    scrolloff = 8,
    smoothscroll = true,
    termguicolors = true,
    signcolumn = "yes",
    inccommand = "nosplit",
    splitright = true,
    splitbelow = false,
    splitkeep = "screen",
    timeout = false,
    updatetime = 500,
    swapfile = true,
    dir = os.getenv("HOME") .. "/.local/state/nvim/swap",
    writebackup = false,
    shortmess = {
        append = "c",
    },
    showmode = false,
    laststatus = 2,
    undofile = true,
    undodir = os.getenv("HOME") .. "/.local/state/nvim/undo",
    wildmode = "longest,list,full",
    wildoptions = {
        remove = "pum"
    },
    winminwidth = 5,
    pumheight = 4,
    wrap = true,
    indentkeys = {
        remove = ":,<>>"
    }
}

options.prg = {
    grep = "rg --vimgrep --no-heading --smart-case",
}

options.globals = {
    markdown_recommended_style = 0,
}

local function set_option(name, opts)
    local obj = vim.opt[name]
    for func, value in pairs(opts) do
        if type(value) ~= "table" then
            obj[func](obj, value)
        else
            for _, atom in ipairs(value) do
                obj[func](obj, atom)
            end
        end
    end
end

for key, value in pairs(options.prg) do
    key = key .. "prg"
    vim.opt[key] = value
end

for key, value in pairs(options.globals) do
    vim.g[key] = value
end

for key, value in pairs(options.options) do
    if type(value) ~= "table" then
        vim.opt[key] = value
    else
    set_option(key, value)
    end
end

vim.opt.guifont = "Iosevka Custom:h14.2"

-- neovide only
if vim.g.neovide then
    vim.g.neovide_scale_factor = 1.0
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_refresh_rate = 144
    vim.g.neovide_cursor_vfx_mode = ""
    vim.g.neovide_fullscreen = true
    vim.g.neovide_floating_shadow = false
    vim.g.neovide_cursor_animation_length = 0
    vim.g.neovide_cursor_trail_size = 0.2
    vim.g.neovide_cursor_animate_command_line = false
    vim.g.neovide_scroll_animation_length = 0
    vim.g.neovide_position_animation_length = 0
end
