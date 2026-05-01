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
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
        },
        config = function()
            require('mason').setup()
            vim.lsp.config('rust_analyzer', {
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
        "mfussenegger/nvim-dap",
        config = function()
            require("nvim-dap-virtual-text").setup({})
            local dap = require("dap")
            dap.adapters.lldb = {
                type = "executable",
                command = LLDB_VSCODE,
                name = "lldb",
            }
            local profile_util = require('lazy.profile_util')
            dap.configurations.rust = {
                {
                    name = "Launch Rust Debug",
                    type = "lldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", profile_util.Get_first_open_dir() .. "/target/debug/", "file")
                    end,
                    cwd = profile_util.Get_first_open_dir(),
                    stopOnEntry = false,
                    args = {},
                },
            }
        end,
    },
}
