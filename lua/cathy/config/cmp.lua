-- cmp
---@diagnostic disable-next-line
local cmp = require("cmp")
local types = require("cmp.types")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local icons = require("util.icons").icons
local ts_utils = require("nvim-treesitter.ts_utils")
-- local has_words_before = function()
--  unpack = unpack or table.unpack
--  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- end

---@diagnostic disable-next-line
cmp.setup({
    preselect = cmp.PreselectMode.None,
    sources = cmp.config.sources({
        { name = 'nvim_lsp_signature_help' },
        {
            name = "nvim_lsp",
            entry_filter = function(entry, _)
                local check_text = types.lsp.CompletionItemKind[entry:get_kind()]
                if check_text == "Text" then return false end

                return true
            end
        },
    }),

    window = {
        ---@diagnostic disable-next-line
        completion = {
            border = "none",
            side_padding = 0,
            col_offset = -3,
        },
        documentation = {
            border = "rounded",
            col_offset = 0,
            scrollbar = true,
            scrolloff = 0,
            side_padding = 1,
            winhighlight = "FloatNormal:Float,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
            zindex = 1001
        }
    },

    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },

    mapping = {
        ["<c-n>"] = cmp.mapping.select_next_item(cmp_select),
        ["<c-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<c-y>"] = cmp.mapping.confirm({ select = false}),
        -- ["<c-cr>"] = cmp.mapping.confirm({ select = false}),
        ["<c-e>"] = cmp.mapping.abort(),
        ["<c-x>c"] = cmp.mapping.complete(),
        ["<c-g>"] = cmp.mapping(function()
            if cmp.visible_docs() then
                cmp.close_docs()
            else
                cmp.open_docs()
            end
        end),
        ["<c-u>"] = cmp.mapping.scroll_docs(-4),
        ["<c-d>"] = cmp.mapping.scroll_docs(4),
    },

    view = {
        docs = {
            auto_open = false
        }
    },

    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function (_, item)
            local kind = item.kind or ""

            item.kind = " " .. (icons[kind] or icons["Unknown"]) .. " "
            item.menu = ""
            item.abbr = item.abbr:match("[^(]+")

            return item
        end,
    },

    ---@diagnostic disable-next-line
    sorting = {
        comparators = {
            cmp.config.compare.recently_used,
            function(entry1, entry2)
                local kind1 = entry1:get_kind()
                local kind2 = entry2:get_kind()
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
            cmp.config.compare.kind
        }
    },
})
