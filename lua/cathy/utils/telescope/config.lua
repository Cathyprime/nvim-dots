local M = {}

M.borderchars = {
    prompt  = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    results = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
}

M.layout_config = {
    prompt_position = "top",
    height = math.floor(vim.opt.lines:get() * 0.4),
    preview_width = 0.60,
}

M.border = false

M.ignores = {
    "node%_modules/*",
    "venv/*",
    "%.git/*",
    "%.mypy_cache/",
    ".*class$",
    ".*bin$",
    ".*tar$",
    ".*zip$",
    ".*jar$",
    "obj/.*",
    "%.gradle/.*",
}

return M
