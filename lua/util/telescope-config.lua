local M = {}

M.borderchars = {
    prompt  = { "",  "",  "",  "",  "",  "",  "",  ""  },
    results = { "",  "",  "",  "",  "",  "",  "",  ""  },
    preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
}

M.layout_config = {
    prompt_position = "bottom",
    height = 14,
    preview_width = 0.60,
}

M.border = true

M.ignores = {
    "node%_modules/*",
    "venv/*",
    "%.git/*",
    "%.mypy_cache/",
    ".*class",
    ".*bin",
    ".*tar",
    ".*zip",
    ".*jar",
}

return M
