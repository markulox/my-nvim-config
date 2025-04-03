return {
    -- Go development support
    {
        "fatih/vim-go",
        build = ":GoUpdateBinaries",
        config = function()
            vim.g.go_fmt_command = "gofumpt" -- Use gofumpt for formatting
            vim.g.go_imports_autosave = 1
            vim.g.go_def_mapping_enabled = 0
        end,
    },
    -- LSP for Go
    {
        "neovim/nvim-lspconfig",
        dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({ ensure_installed = { "gopls" } })

            local lspconfig = require("lspconfig")
            lspconfig.gopls.setup({
                cmd = { "gopls" },
                settings = {
                    gopls = {
                        gofumpt = true,
                        staticcheck = true,
                        usePlaceholders = true,
                        analyses = {
                            unusedparams = true,
                        },
                    },
                },
            })
        end,
    },

    -- Treesitter for syntax highlighting
    -- {
    --     "nvim-treesitter/nvim-treesitter",
    --     build = ":TSUpdate",
    --     opts = {
    --         ensure_installed = { "go", "gomod", "gosum", "gowork" },
    --         highlight = { enable = true },
    --         indent = { enable = true },
    --     },
    -- },

    -- Debugging with Delve
    {
        "mfussenegger/nvim-dap",
        dependencies = { "leoluz/nvim-dap-go" },
        config = function()
            require("dap-go").setup()
        end,
    },

    -- Test running
    {
        "vim-test/vim-test",
        config = function()
            vim.g["test#go#runner"] = "richgo"
            vim.api.nvim_set_keymap("n", "<leader>tt", ":TestNearest<CR>", { noremap = true, silent = true })
            vim.api.nvim_set_keymap("n", "<leader>tf", ":TestFile<CR>", { noremap = true, silent = true })
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
