return {
    {
        "Saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        opts = {
            completion = {
                crates = {
                    enabled = true,
                },
            },
            lsp = {
                enabled = true,
                actions = true,
                completion = true,
                hover = true,
            },
        },
    },
    -- {
    --     "nvim-treesitter/nvim-treesitter",
    --     opts = {
    --         ensure_installed = { "rust", "ron", "lua", "toml" },
    --         auto_install = true,
    --         highlight = {
    --             enable = true,
    --             additional_vim_regex_highlighting = false,
    --         },
    --         ident = { enable = true },
    --         rainbow = {
    --             enable = true,
    --             extended_mode = true,
    --             max_file_lines = nil,
    --         }
    --     },
    -- },
    {
        "williamboman/mason.nvim",
        dependencies = { "williamboman/mason-lspconfig.nvim", "neovim/nvim-lspconfig" },
        config = function(_, opts)
            require('mason').setup()
            require('mason-lspconfig').setup({
                ensure_installed = {
                    "html",
                    "cssls"
                },
                automatic_installation = true,
            })

            local lspconfig = require("lspconfig")
            -- Setup html language server
            lspconfig.html.setup({
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

            -- Setup rust_analyzer language server
            lspconfig.rust_analyzer.setup({
                settings = {
                    ["rust-analyzer"] = {
                        imports = {
                            granularity = { group = "module" },
                            prefix = "self",
                        },
                        cargo = {
                            allFeatures = true,
                            buildScripts = {
                                enable = true
                            }
                        },
                        checkOnSave = { command = "clippy" },
                        diagnostics = { enable = true },
                        inlayHints = { enable = true }
                    }
                }
            })
        end,
    },
    -- {
    --     "simrat39/rust-tools.nvim",
    --     dependencies = { "neovim/nvim-lspconfig" },
    --     config = function()
    --         require("rust-tools").setup({
    --             tools = {
    --                 inlay_hints = { auto = true }, -- Automatically enable inlay hints
    --             },
    --             server = {
    --             -- Setup rust_analyzer language server
    --                 settings = {
    --                     ["rust-analyzer"] = {
    --                         imports = {
    --                             granularity = { group = "module" },
    --                             prefix = "self",
    --                         },
    --                         cargo = {
    --                             allFeatures = true,
    --                             buildScripts = {
    --                                 enable = true
    --                             }
    --                         },
    --                         checkOnSave = { command = "clippy" },
    --                         diagnostics = { enable = true },
    --                         inlayHints = { enable = true }
    --                     }
    --                 }
    --             },
    --         })
    --     end,
    -- },
    {
        "nvim-neotest/neotest",
        optional = true,
        opts = {
            adapters = {
                ["rustaceanvim.neotest"] = {},
            },
        },
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
    },
    -- {
    --     "olimorris/codecompanion.nvim",
    --     config = true,
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --         "nvim-treesitter/nvim-treesitter",
    --     },
    -- },
}
