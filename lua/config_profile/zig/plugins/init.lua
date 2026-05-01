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
                automatic_enable = false
            }
            vim.lsp.config('zls', {
                semantic_tokens = "full",
                warn_style = true,
            })
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
    {
        "mfussenegger/nvim-dap",
        config = function()
            require("nvim-dap-virtual-text").setup({})
            local dap = require("dap")
            dap.adapters.lldb = {
                type = "executable",
                command = vim.fn.expand("~/.config/nvim/extensions/vadimcn.codelldb.v1.11.4/adapter/codelldb"),
                name = "lldb",
            }

            local profile_util = require("lazy.profile_util")
            dap.configurations.zig = {
                {
                    name = "Launch Zig Debug",
                    type = "lldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", profile_util.Get_first_open_dir() .. "/zig-out/bin/", "file")
                    end,
                    cwd = profile_util.Get_first_open_dir(),
                    stopOnEntry = false,
                    args = {},
                },
            }
        end,
    },
}
