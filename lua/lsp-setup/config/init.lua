local M = {}

M.lazy_version = ">=9.1.0"

local defaults = {
	icons = {
		dap = {
			Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
			Breakpoint = " ",
			BreakpointCondition = " ",
			BreakpointRejected = { " ", "DiagnosticError" },
			LogPoint = ".>",
		},
		diagnostics = {
			Error = " ",
			Warn = " ",
			Hint = " ",
			Info = " ",
		},
		git = {
			added = " ",
			modified = " ",
			removed = " ",
		},
		kinds = {
			Array = " ",
			Boolean = " ",
			Class = " ",
			Color = " ",
			Constant = " ",
			Constructor = " ",
			Copilot = " ",
			Enum = " ",
			EnumMember = " ",
			Event = " ",
			Field = " ",
			File = " ",
			Folder = " ",
			Function = " ",
			Interface = " ",
			Key = " ",
			Keyword = " ",
			Method = " ",
			Module = " ",
			Namespace = " ",
			Null = " ",
			Number = " ",
			Object = " ",
			Operator = " ",
			Package = " ",
			Property = " ",
			Reference = " ",
			Snippet = " ",
			String = " ",
			Struct = " ",
			Text = " ",
			TypeParameter = " ",
			Unit = " ",
			Value = " ",
			Variable = " ",
		},
	},
}

local options

function M.setup(opts)
	options = vim.tbl_deep_extend("force", defaults, opts or {})
	if not M.has() then
		require("lazy.core.util").error(
			"**LazyVim** needs **lazy.nvim** version "
				.. M.lazy_version
				.. " to work properly.\n"
				.. "Please upgrade **lazy.nvim**",
			{ title = "LazyVim" }
		)
		error("Exiting")
	end

	require("lazy.core.util").try(function()
		if type(M.colorscheme) == "function" then
			M.colorscheme()
		else
			vim.cmd.colorscheme(M.colorscheme)
		end
	end, {
		msg = "Could not load your colorscheme",
		on_error = function(msg)
			require("lazy.core.util").error(msg)
			vim.cmd.colorscheme("habamax")
		end,
	})
end

---@param range? string
function M.has(range)
	local Semver = require("lazy.manage.semver")
	return Semver.range(range or M.lazy_version):matches(require("lazy.core.config").version or "0.0.0")
end

---@param name "autocmds" | "options" | "keymaps"
function M.load(name)
	local Util = require("lazy.core.util")
	local function _load(mod)
		Util.try(function()
			require(mod)
		end, {
			msg = "Failed loading " .. mod,
			on_error = function(msg)
				local info = require("lazy.core.cache").find(mod)
				if info == nil or (type(info) == "table" and #info == 0) then
					return
				end
				Util.error(msg)
			end,
		})
	end
	if M.defaults[name] or name == "options" then
		_load("lsp-setup.config." .. name)
	end
	_load("config." .. name)
	if vim.bo.filetype == "lazy" then
		vim.cmd([[do VimResized]])
	end
	local pattern = "LazyVim" .. name:sub(1, 1):upper() .. name:sub(2)
	vim.api.nvim_exec_autocmds("User", { pattern = pattern, modeline = false })
end

M.did_init = false
function M.init()
	if not M.did_init then
		M.did_init = true
		-- delay notifications till vim.notify was replaced or after 500ms
		require("lsp-setup.util").lazy_notify()

		-- load options here, before lazy init while sourcing plugin modules
		-- this is needed to make sure options will be correctly applied
		-- after installing missing plugins
		require("lsp-setup.config").load("options")
		local Plugin = require("lazy.core.plugin")
		local add = Plugin.Spec.add
		Plugin.Spec.add = function(self, plugin, ...)
			if type(plugin) == "table" and M.renames[plugin[1]] then
				plugin[1] = M.renames[plugin[1]]
			end
			return add(self, plugin, ...)
		end
	end
end

setmetatable(M, {
	__index = function(_, key)
		if options == nil then
			return vim.deepcopy(defaults)[key]
		end
		return options[key]
	end,
})

return M
