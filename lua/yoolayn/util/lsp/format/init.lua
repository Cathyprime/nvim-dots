local Util = require("lazy.core.util")

local M = {}

---@param opts PluginLspOpts
function M.setup(opts)
	M.opts = opts
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = vim.api.nvim_create_augroup("LazyVimFormat", {}),
		callback = function()
			if M.opts.autoformat then
				M.format()
			end
		end,
	})
end

function M.format(opts)
	local buf = vim.api.nvim_get_current_buf()
	if vim.b.autoformat == false and not (opts and opts.force) then
		return
	end

	local formatters = M.get_formatters(buf)
	local client_ids = vim.tbl_map(function(client)
		return client.id
	end, formatters.active)

	if #client_ids == 0 then
		return
	end

	if M.opts.format_notify then
		M.notify(formatters)
	end

	vim.lsp.buf.format(vim.tbl_deep_extend("force", {
		bufnr = buf,
		filter = function(client)
			return vim.tbl_contains(client_ids, client.id)
		end,
	}, require("yoolayn.util.funcs").opts("nvim-lspconfig").format or {}))
end

return M
