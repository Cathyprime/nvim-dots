vim.b["dispatch"] = "firefox %"
local buf = vim.api.nvim_get_current_buf()
vim.api.nvim_set_option_value("tabstop", 2, { buf = buf })
vim.api.nvim_set_option_value("shiftwidth", 2, { buf = buf })
vim.api.nvim_set_option_value("expandtab", false, { buf = buf })
