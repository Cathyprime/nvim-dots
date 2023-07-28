return {
    {
        "anuvyklack/hydra.nvim",
    },
    {
        "mbbill/undotree",
        keys = {
            {
                "<leader>uu",
                "<cmd>UndotreeToggle<cr>",
                desc = "Undo tree",
            },
        },
    },
    {
        "ThePrimeagen/harpoon",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        keys = {
            {
                "<leader>h",
                function()
                    require("harpoon.ui").toggle_quick_menu()
                end,
                desc = "Menu",
            },
            {
                "<leader>a",
                function()
                    require("harpoon.mark").add_file()
                end,
                desc = "Add File",
            },
            {
                "<C-f>",
                function()
                    require("harpoon.ui").nav_file(1)
                end,
                desc = "go to file 1",
            },
            {
                "<C-s>",
                function()
                    require("harpoon.ui").nav_file(2)
                end,
                desc = "go to file 2",
            },
            {
                "<c-n>",
                function()
                    require("harpoon.ui").nav_file(3)
                end,
                desc = "go to file 3",
            },
            {
                "<c-h>",
                function()
                    require("harpoon.ui").nav_file(4)
                end,
                desc = "go to file 4",
            },
        },
        config = function()
            require("telescope").load_extension("harpoon")
        end,
    },
    {
        "echasnovski/mini.pairs",
        event = "VeryLazy",
        opts = {},
    },
    {
        "echasnovski/mini.surround",
        opts = {
            mappings = {
                find = nil,
                find_left = nil,
                highlight = nil,
                update_n_line = nil,
            },
            n_lines = nil,
            respect_selection_type = true,
        },
    },
    {
        "echasnovski/mini.comment",
        event = "VeryLazy",
        opts = {
            options = {
                custom_commentstring = function()
                    return require("ts_context_commentstring.internal").calculate_commentstring()
                        or vim.bo.commentstring
                end,
            },
        },
    },
    {
        "echasnovski/mini.ai",
        event = "VeryLazy",
        dependencies = { "nvim-treesitter-textobjects" },
        opts = function()
            local ai = require("mini.ai")
            return {
                n_lines = 500,
                custom_textobjects = {
                    o = ai.gen_spec.treesitter({
                        a = {
                            "@block.outer",
                            "@conditional.outer",
                            "@loop.outer",
                        },
                        i = {
                            "@block.inner",
                            "@conditional.inner",
                            "@loop.inner",
                        },
                    }, {}),
                    f = ai.gen_spec.treesitter(
                        { a = "@function.outer", i = "@function.inner" },
                        {}
                    ),
                    c = ai.gen_spec.treesitter(
                        { a = "@class.outer", i = "@class.inner" },
                        {}
                    ),
                },
            }
        end,
        config = function(_, opts)
            require("mini.ai").setup(opts)
            -- register all text objects with which-key
            require("lsp-setup.util").on_load("which-key.nvim", function()
                ---@type table<string, string|table>
                local i = {
                    [" "] = "Whitespace",
                    ['"'] = 'Balanced "',
                    ["'"] = "Balanced '",
                    ["`"] = "Balanced `",
                    ["("] = "Balanced (",
                    [")"] = "Balanced ) including white-space",
                    [">"] = "Balanced > including white-space",
                    ["<lt>"] = "Balanced <",
                    ["]"] = "Balanced ] including white-space",
                    ["["] = "Balanced [",
                    ["}"] = "Balanced } including white-space",
                    ["{"] = "Balanced {",
                    ["?"] = "User Prompt",
                    _ = "Underscore",
                    a = "Argument",
                    b = "Balanced ), ], }",
                    c = "Class",
                    f = "Function",
                    o = "Block, conditional, loop",
                    q = "Quote `, \", '",
                    t = "Tag",
                }
                local a = vim.deepcopy(i)
                for k, v in pairs(a) do
                    a[k] = v:gsub(" including.*", "")
                end

                local ic = vim.deepcopy(i)
                local ac = vim.deepcopy(a)
                for key, name in pairs({ n = "Next", l = "Last" }) do
                    i[key] = vim.tbl_extend(
                        "force",
                        { name = "Inside " .. name .. " textobject" },
                        ic
                    )
                    a[key] = vim.tbl_extend(
                        "force",
                        { name = "Around " .. name .. " textobject" },
                        ac
                    )
                end
            end)
        end,
    },
    {
        "folke/flash.nvim",
        opts = {},
		-- stylua: ignore
		keys = {
			{ "gs", mode = { "n", "o", "x"}, function() require("flash").jump() end, desc = "Flash" },
			{ "S", mode = { "n", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
			{ "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
			{ "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
			{ "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
		},
    },
    {
        "folke/trouble.nvim",
        cmd = { "TroubleToggle", "Trouble" },
        opts = { use_diagnostic_signs = true },
        keys = {
            {
                "<leader>xx",
                "<cmd>TroubleToggle document_diagnostics<cr>",
                desc = "Document Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>TroubleToggle workspace_diagnostics<cr>",
                desc = "Workspace Diagnostics (Trouble)",
            },
        },
    },
    {
        "folke/todo-comments.nvim",
        cmd = { "TodoTrouble", "TodoTelescope" },
        event = { "BufReadPost", "BufNewFile" },
        config = true,
		-- stylua: ignore
		keys = {
			{ "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "display todo using trouble" },
			{ "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "find todo" },
		},
    },
}
