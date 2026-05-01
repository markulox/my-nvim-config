-- local rust_plugins = require('config_profile.rust_dev.plugins.init')
-- local svelte_plugins = require('config_profile.svelte.plugins.init')
--
-- for _, each_rust_plugin in ipairs(rust_plugins) do
--     table.insert(svelte_plugins, each_rust_plugin)
-- end
-- return rust_plugins
--

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
                    "cssls",
                    "tailwindcss"
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

            -- Setup rust_analyzer language server
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
                        checkOnSave = { enable = true },
                        check = { command = "clippy" },
                        diagnostics = { enable = true },
                        inlayHints = { enable = true }
                    }
                }
            })

            -- Setup tailwind css language server
            vim.lsp.config('tailwindcss-language-server', {})
        end
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
            dap.configurations.rust = {
                {
                    name = "Launch Rust Debug",
                    type = "lldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", Get_first_open_dir() .. "/target/debug/", "file")
                    end,
                    cwd = Get_first_open_dir(),
                    stopOnEntry = false,
                    args = {},
                },
            }
        end,
    },
}
