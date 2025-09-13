return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer", -- Buffer completion
            "hrsh7th/cmp-path", -- Path completion
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
    {
        "neovim/nvim-lspconfig",
        dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "pyright",
                    --"pylyzer"
                },
                auto_install = true,
                automatic_enable = false,
            })

            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            lspconfig.pyright.setup({
                on_attach = function(client, bufnr)
                    local bufopts = { noremap = true, silent = true, buffer = bufnr }
                    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
                    vim.keymap.set('v', '<leader>ca', vim.lsp.buf.code_action, bufopts)
                end,
                capabilities = capabilities,
                settings = {
                    python = {
                        analysis = {
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                            diagnosticMode = "workspace"
                        },
                    },
                },
            })
            -- lspconfig.pylyzer.setup({
            --   capabilities = capabilities,
            --   settings = {
            --     pylyzer = {
            --       checkOnType = true,           -- enable real-time type checking
            --       diagnostics = true,           -- enable diagnostic messages
            --       reportMissingImports = true,  -- show warnings when imports are missing
            --       inlayHints = {
            --         enable = true,              -- show type hints inline
            --         parameterNames = true,      -- show parameter names for functions
            --         typeHints = true,           -- show type hints for variables
            --       },
            --       analysis = {
            --         --autoSearchPaths = true,        -- automatically include common lib paths
            --         useLibraryCodeForTypes = true, -- use types from installed packages
            --         diagnosticMode = "workspace",  -- "workspace" or "openFilesOnly"
            --       },
            --       telemetry = {
            --         enable = false, -- disable telemetry (recommended for privacy)
            --       }
            --     }
            --   }
            -- })
        end,
    },

    -- Mason integration for none-ls
    {
        "jay-babu/mason-null-ls.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "nvimtools/none-ls.nvim",
        },
        config = function()
            require("mason-null-ls").setup({
                ensure_installed = { "black", "isort" },
                automatic_installation = true,
            })
        end,
    },

    -- Formatting with none-ls (successor to null-ls)
    {
        "nvimtools/none-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    -- Black for Python formatting (using Mason-installed version)
                    null_ls.builtins.formatting.black.with({
                        extra_args = { "--line-length", "88" },
                    }),
                    -- isort for import sorting (using Mason-installed version)
                    null_ls.builtins.formatting.isort,
                },
                -- Format on save
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({ async = false })
                            end,
                        })
                    end
                end,
            })
        end,
    },

    -- Virtual environment selector
    {
        "linux-cultist/venv-selector.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "mfussenegger/nvim-dap", "mfussenegger/nvim-dap-python", --optional
            { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
        },
        lazy = false,
        keys = {
            -- Keymap to open VenvSelector to pick a venv.
            { "<leader>vs", "<cmd>VenvSelect<cr>" },
            -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
            { "<leader>vc", "<cmd>VenvSelectCached<cr>" },
        },
        opts = {
            name = ".venv",
            auto_refresh = false,
        },
    },

    -- {
    --   "nvim-treesitter/nvim-treesitter",
    --   opts = {
    --     ensure_installed = { "python", "lua", "vim", "vimdoc" },
    --     auto_install = true,
    --     highlight = {
    --       enable = true,
    --       additional_vim_regex_highlighting = false,
    --     },
    --     ident = { enable = true },
    --     rainbow = {
    --       enable = true,
    --       extended_mode = true,
    --       max_file_lines = nil,
    --     }
    --   },
    -- }
}
