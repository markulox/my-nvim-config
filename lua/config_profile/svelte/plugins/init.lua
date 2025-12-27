return {
    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
        },
        config = function(_, opts)
            require('mason').setup()
            require('mason-lspconfig').setup({
                ensure_installed = {
                    "svelte",
                    "html",
                    "cssls"
                },
                automatic_installation = true
            })

            -- Setup html language server
            vim.lsp.config('html-lsp', {
                filetypes = { "html" },
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
            })

            -- Setup css language server
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.completion.completionItem.snippetSupport = true
            vim.lsp.config('cssls', {
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

            -- Setup svelte language server
            vim.lsp.config('svelte', {})
        end
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

}

