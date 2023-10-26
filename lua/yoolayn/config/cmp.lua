-- cmp
local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local icons = require("util.icons").icons
local kind_mapper = require("cmp.types").lsp.CompletionItemKind

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
		{ name = "nvim_lua" },
		{ name = "nvim_lsp" },
		{ name = "path" },
	}, {
		{ name = "look", keyword_length = 5 },
		{ name = "buffer", keyword_length = 3 },
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

	-- completion = {
	-- 	autocomplete = false,
	-- },

	sorting = {
		---@
		comparators = {
			cmp.config.compare.score,
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
