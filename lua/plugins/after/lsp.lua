return {
    "VonHeikemen/lsp-zero.nvim",
    config = function ()
        local lsp = require('lsp-zero').preset({})
        local ls = require("luasnip")

        -- keybinds
        lsp.on_attach(function(_, bufnr)
            -- see :help lsp-zero-keybindings
            -- to learn the available actions
            lsp.default_keymaps({buffer = bufnr})
            vim.keymap.set("n", "<leader>ca", function () vim.lsp.buf.code_action() end, {buffer = bufnr, desc = "code actions"})
            vim.keymap.set("n", "<leader>crn", function() vim.lsp.buf.rename() end, { buffer = bufnr, desc = "rename variable"})
            vim.keymap.set("n", "<leader>fr", "<cmd>Telescope lsp_references<cr>", {buffer = true})
            vim.keymap.set("i", "<c-h>", function() vim.lsp.buf.signature_help() end, {buffer = bufnr, desc = "show signature"})
            vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
        end)

        -- required servers
        lsp.ensure_installed({
            "alex",
            "jsonls",
            "lua_ls",
            "pylsp",
            "rust_analyzer",
            "tailwindcss",
            "tsserver",
            "yamlls",
        })

        -- cmp
        local cmp = require("cmp")
        local cmp_select = { behavior = cmp.SelectBehavior.Select }
        local cmp_action = require('lsp-zero').cmp_action()
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
        lsp.setup_nvim_cmp({
            sources = cmp.config.sources({
                { name = "luasnip" },
                { name = "nvim_lsp" },
                { name = "path" },
            }, {
                { name = "look", keyword_length = 5 },
                { name = "buffer", keyword_length = 3 },
            }),

            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },

            mapping = {
                ["<c-n>"] = cmp.mapping.select_next_item(cmp_select),
                ["<c-p>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<cr>"] = cmp.mapping.confirm({ select = false}),
                ["<c-e>"] = cmp.mapping.abort(),
                ["<c-c>"] = cmp.mapping.complete(),
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

            completion = {
                autocomplete = false,
            },

            sorting = {
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

        -- server setups
        require("lspconfig").tsserver.setup({
            settings = {
                typescript = {
                    format = {
                        indentSize = vim.o.shiftwidth,
                        convertTabsToSpaces = vim.o.expandtab,
                        tabSize = vim.o.tabstop,
                    },
                },
                javascript = {
                    format = {
                        indentSize = vim.o.shiftwidth,
                        convertTabsToSpaces = vim.o.expandtab,
                        tabSize = vim.o.tabstop,
                    },
                },
                completions = {
                    completeFunctionCalls = true,
                },
            }
        })

        require("lspconfig").tailwindcss.setup({
            filetypes_exclude = { "markdown" },
        })

        require("lspconfig").rust_analyzer.setup({
            settings = {
                ["rust-analyzer"] = {
                    cargo = {
                        allFeatures = true,
                        loadOutDirsFromCheck = true,
                        runBuildScripts = true,
                    },
                    checkOnSave = {
                        allFeatures = true,
                        command = "clippy",
                        extraArgs = { "--no-deps" },
                    },
                    procMacro = {
                        enable = true,
                        ignored = {
                            ["async-trait"] = { "async_trait" },
                            ["napi-derive"] = { "napi" },
                            ["async-recursion"] = { "async_recursion" },
                        },
                    },
                },
            }
        })

        lsp.setup()
        vim.keymap.set({"i"}, "<c-e>", function() ls.expand() end, {silent = true})
        vim.keymap.set({"i", "s"}, "<c-j>", function() ls.jump( 1) end, {silent = true})
        vim.keymap.set({"i", "s"}, "<c-k>", function() ls.jump(-1) end, {silent = true})

        vim.keymap.set({"i", "s"}, "<c-s>", function()
            if ls.choice_active() then
                ls.change_choice(1)
            end
        end, {silent = true})
    end
}
