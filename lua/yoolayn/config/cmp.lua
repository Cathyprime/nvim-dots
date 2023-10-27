-- cmp
local cmp = require("cmp")
local types = require("cmp.types")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local icons = require("util.icons").icons
local kind_mapper = require("cmp.types").lsp.CompletionItemKind
local ts_utils = require("nvim-treesitter.ts_utils")

vim.api.nvim_create_autocmd("VimEnter", {
	callback = function ()
		vim.api.nvim_set_hl(0, "CmpItemMenu", {
			fg = "#c792ea",
			italic = true,
		})
	end,
	once = true
})

-- cmp settings
---@diagnostic disable-next-line
cmp.setup({
	sources = cmp.config.sources({
		{ name = "path" },
		{ name = "nvim_lua" },
		{
			name = "nvim_lsp",
			entry_filter = function(entry, _)
				local check_text = types.lsp.CompletionItemKind[entry:get_kind()]
				if check_text == "Text" then return false end

				return true
			end
		},
	}),

	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},

	mapping = {
		["<c-n>"] = cmp.mapping.select_next_item(cmp_select),
		["<c-p>"] = cmp.mapping.select_prev_item(cmp_select),
		["<cr>"] = cmp.mapping.confirm({ select = false}),
		["<c-e>"] = cmp.mapping.abort(),
		["<c-x>c"] = cmp.mapping.complete(),
		["<c-u>"] = cmp.mapping.scroll_docs(-4),
		["<c-d>"] = cmp.mapping.scroll_docs(4),
	},

	---@diagnostic disable-next-line
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function (_, item)
			local kind = item.kind

			item.kind = (icons[kind] or " ")
			item.menu = "(" .. kind .. ")"

			item.abbr = item.abbr:match("[^(]+")

			return item
		end,
	},

	---@diagnostic disable-next-line
	sorting = {
		comparators = {
			function(entry1, entry2)
				local kind1 = entry1.completion_item.kind
				local kind2 = entry2.completion_item.kind
				local node = ts_utils.get_node_at_cursor()

				if node and node:type() == "argument" then
					if kind1 == 6 then
						entry1.score = 100
					end
					if kind2 == 6 then
						entry2.score = 100
					end
				end

				local diff = entry2.score - entry1.score
				if diff < 0 then
					return true
				else
					return false
				end
			end,
			cmp.config.compare.exact,
			cmp.config.compare.recently_used,
			function (entry1, entry2)
				local kind1 = kind_mapper[entry1:get_kind()]
				local kind2 = kind_mapper[entry2:get_kind()]
				if kind1 < kind2 then
					return true
				end
			end
		}
	},
})
