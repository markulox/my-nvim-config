return {
    {
        "ziglang/zig.vim",
        ft = "zig",
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup {
                ensure_installed = { "zls" },
            }
            require("lspconfig").zls.setup {
              on_attach = function(client, bufnr)
                -- Enable inlay hints if supported
                if client.server_capabilities.inlayHintProvider then
                  vim.lsp.inlay_hint.enable(true)
                end
              end,
            }
        end,
    },
    -- {
    --     "nvim-treesitter/nvim-treesitter",
    --     opts = {
    --         ensure_installed = { "zig" },
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
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup {
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<Tab>"] = cmp.mapping.select_next_item(),
                    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" },
                }),
            }
        end,
    },
    {
        "themercorp/themer.lua",
        opts = {
            colorscheme = "scery",
            transparent = true,
            styles = {
                ["function"]    = { style = 'italic' },
                functionbuiltin = { style = 'italic' },
                variable        = { style = 'italic' },
                variableBuiltIn = { style = 'italic' },
                parameter       = { style = 'italic' },
            },
        }
    },
}
