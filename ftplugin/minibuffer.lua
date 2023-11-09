vim.keymap.set({ "n", "i"}, "<c-g>", "norm :close<cr>", { buffer = true, silent = true })
vim.keymap.set({ "n", "i"}, "<c-c>", "<cmd>close<cr>", { buffer = true, silent = true })
vim.keymap.set({"i"}, "<c-k>", "<up>", { buffer = true, silent = true })
vim.keymap.set({"i"}, "<c-j>", "<down>", { buffer = true, silent = true })
vim.api.nvim_win_set_height(0, 1)
vim.opt_local.spell = false
vim.opt_local.winbar = nil
vim.o.laststatus = 0

local old_height = vim.opt.pumheight
vim.opt.pumheight = 3

vim.api.nvim_create_autocmd("CmdwinLeave", {
	once = false,
	callback = function()
		vim.o.laststatus = 3
		vim.opt.pumheight = old_height
	end
})

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")
local cmp = require("cmp")
---@diagnostic disable-next-line
cmp.setup.buffer({
	sources = cmp.config.sources({
		{ name = "path" },
		{ name = "cmdline" },
	}, {
		{ name = "buffer" },
	}, {
		{ name = "nvim_lua" },
	}),

	mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),

  },
})
