local M = {}

---@param opts? LazyVimConfig
function M.setup(opts)
	require("lsp-setup.config").setup(opts)
end

return M
