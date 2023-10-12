return {
	"ThePrimeagen/harpoon",
	keys = {
		{
			"<leader>h",
			function() require("harpoon.ui").toggle_quick_menu() end,
		},
		{
			"<leader>a",
			function() require("harpoon.mark").add_file() end,
		},
		{
			"<C-h>f",
			function() require("harpoon.ui").nav_file(1) end,
		},
		{
			"<C-h>s",
			function() require("harpoon.ui").nav_file(2) end,
		},
		{
			"<c-h>n",
			function() require("harpoon.ui").nav_file(3) end,
		},
		{
			"<c-h>h",
			function() require("harpoon.ui").nav_file(4) end,
		}
	}
}
