vim.cmd.packadd("nvim-jdtls")
local ok, jdtls = pcall(require, "jdtls")
if ok then
    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
            local client = vim.lsp.get_client_by_id(event.data.client_id)
            assert(client)
            client.server_capabilities.semanticTokensProvider = nil
            require("cathy.config.lsp-funcs").on_attach(client, event.buf)

            local function map(opts)
                vim.keymap.set(opts.mode, "<leader>c" .. opts.lhs, opts.rhs, { buffer = event.buf })
            end
            map({
                mode = "n",
                lhs = "ev",
                ---@diagnostic disable-next-line
                rhs = function() jdtls.extract_variable() end
            })
            map({
                mode = "v",
                lhs = "ev",
                ---@diagnostic disable-next-line
                rhs = function() jdtls.extract_variable({ visual = true }) end
            })
            map({
                mode = "n",
                lhs = "ec",
                ---@diagnostic disable-next-line
                rhs = function() jdtls.extract_constant() end
            })
            map({
                mode = "v",
                lhs = "ec",
                ---@diagnostic disable-next-line
                rhs = function() jdtls.extract_constant({ visual = true }) end
            })
            map({
                mode = "v",
                lhs = "em",
                ---@diagnostic disable-next-line
                rhs = function() jdtls.extract_method({ visual = true }) end
            })
        end
    })


    local bundles = {
        vim.fn.glob(vim.env.HOME .. '/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar'),
    }

    vim.list_extend(bundles, vim.split(vim.fn.glob(vim.env.HOME .. "/.local/share/nvim/mason/share/java-test/*.jar", true), "\n"))

    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    local workspace_dir = vim.env.HOME .. "/jdtls-workspace/" .. project_name

    ---@diagnostic disable-next-line
    jdtls.start_or_attach({
        on_attach = function()
            ---@diagnostic disable-next-line: missing-fields
            jdtls.setup_dap({ hotcodereplace = "auto" })
            require("jdtls.dap").setup_dap_main_class_configs()
        end,
        cmd = {
            "java",
            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
            "-Dosgi.bundles.defaultStartLevel=4",
            "-Declipse.product=org.eclipse.jdt.ls.core.product",
            "-Dlog.protocol=true",
            "-Dlog.level=ALL",
            "-javaagent:" .. vim.env.HOME .. "/.local/share/nvim/mason/share/jdtls/lombok.jar",
            "-Xmx4g",
            "--add-modules=ALL-SYSTEM",
            "--add-opens", "java.base/java.util=ALL-UNNAMED",
            "--add-opens", "java.base/java.lang=ALL-UNNAMED",

            -- Eclipse jdtls location
            "-jar", vim.env.HOME .. "/.local/share/nvim/mason/share/jdtls/plugins/org.eclipse.equinox.launcher.jar",
            -- TODO Update this to point to the correct jdtls subdirectory for your OS (config_linux, config_mac, config_win, etc)
            "-configuration", vim.env.HOME .. "/.local/share/nvim/mason/packages/jdtls/config_linux",
            "-data", workspace_dir
        },
        root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'pom.xml', 'build.gradle'}),

        settings = {
            java = {
                -- TODO Replace this with the absolute path to your main java version (JDK 17 or higher)
                home = "/usr/bin/java",
                eclipse = {
                    downloadSources = true,
                },
                configuration = {
                    updateBuildConfiguration = "interactive",
                    -- TODO Update this by adding any runtimes that you need to support your Java projects and removing any that you don't have installed
                    -- The runtime name parameters need to match specific Java execution environments.  See https://github.com/tamago324/nlsp-settings.nvim/blob/2a52e793d4f293c0e1d61ee5794e3ff62bfbbb5d/schemas/_generated/jdtls.json#L317-L334
                },
                maven = {
                    downloadSources = true,
                },
                implementationsCodeLens = {
                    enabled = true,
                },
                referencesCodeLens = {
                    enabled = true,
                },
                references = {
                    includeDecompiledSources = true,
                },
                signatureHelp = { enabled = true },
                format = {
                    enabled = true,
                    -- Formatting works by default, but you can refer to a specific file/URL if you choose
                    -- settings = {
                    --   url = "https://github.com/google/styleguide/blob/gh-pages/intellij-java-google-style.xml",
                    --   profile = "GoogleStyle",
                    -- },
                },
            },
            completion = {
                favoriteStaticMembers = {
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*",
                },
                importOrder = {
                    "java",
                    "javax",
                    "com",
                    "org"
                },
            },
            extendedClientCapabilities = jdtls.extendedClientCapabilities,
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
            codeGeneration = {
                toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                },
                useBlocks = true,
            },
        },
        -- Needed for auto-completion with method signatures and placeholders
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        flags = {
            allow_incremental_sync = true,
        },
        init_options = {
            -- References the bundles defined above to support Debugging and Unit Testing
            bundles = bundles
        },
    })
else
    vim.notify("jdtls not found: " .. jdtls, vim.log.levels.WARN)
end
