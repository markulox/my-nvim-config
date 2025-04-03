require("lazy.nvim_profile");

return {
    { -- For TS syntax hilight
        "sheerun/vim-polyglot"
    },
    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
        },
        config = function()
            require('mason').setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "angularls",
                    "ts_ls",
                    "html",
                    "cssls"
                },
                automatic_installation = true, -- Ensures LSPs are installed automatically
            })
            local lspconfig = require("lspconfig")

            -- Setup ts language server
            lspconfig.ts_ls.setup ({
                cmd = { "typescript-language-server", "--stdio" }
            })

            -- Setup html language server
            lspconfig.html.setup ({
                filetypes = { "html" },
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
            })

            -- Setup css language server
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true
            lspconfig.cssls.setup({
                capabilities = capabilities,
                cmd = { "vscode-css-language-server", "--stdio" },
                filetypes = { "css", "scss", "less" },
                init_options = {
                    provideFormatter = true
                },
                settings = {
                    css = {
                      validate = true
                    },
                    less = {
                      validate = true
                    },
                    scss = {
                      validate = true
                    }
                },
                single_file_support = true
            })

            -- Setup angular language server
            local mason_registry = require("mason-registry")
            local angularls_path = mason_registry.get_package("angular-language-server"):get_install_path()
            local angular_cmd = {
                "ngserver",
                "--stdio",
                "--tsProbeLocations",
                table.concat({
                    angularls_path,
                    get_first_open_dir(),
                }, ","),
                "--ngProbeLocations",
                table.concat({
                    angularls_path .. "/node_modules/@angular/language-server",
                    get_first_open_dir(),
                }, ","),
            }

            lspconfig.angularls.setup({
                filetypes = { "typescript", "html", "typescriptreact", "angular" },
                cmd = angular_cmd,
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
                on_new_config = function(new_config, new_root_dir)
                    new_config.cmd = angular_cmd
                end,
            })
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",  -- Buffer completion
            "hrsh7th/cmp-path",    -- Path completion
            "hrsh7th/cmp-cmdline", -- Command-line completion
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        opts = function()
            local cmp = require("cmp")
            return {
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                }),
            }
        end
    }
}
