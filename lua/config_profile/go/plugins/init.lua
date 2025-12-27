return {
    -- Go development support
    {
        "fatih/vim-go",
        build = ":GoUpdateBinaries",
        config = function()
            vim.g.go_fmt_command = "gofumpt" -- Use gofumpt for formatting
            vim.g.go_imports_autosave = 1
            vim.g.go_def_mapping_enabled = 0
            vim.g.go_gopls_enabled = 1
        end,
    },
    -- LSP for Go
    {
        "neovim/nvim-lspconfig",
        dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = { "gopls" },
                automatic_enable = false
            })

            -- local lspconfig = require("lspconfig")
            vim.lsp.config('gopls', {
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
    --
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
            require("dap-go").setup(
            --     {
            --     delve = {
            --         -- the path to the executable dlv which will be used for debugging.
            --         -- by default, this is the "dlv" executable on your PATH.
            --         path = "dlv",
            --         -- time to wait for delve to initialize the debug session.
            --         -- default to 20 seconds
            --         initialize_timeout_sec = 20,
            --         -- a string that defines the port to start delve debugger.
            --         -- default to string "${port}" which instructs nvim-dap
            --         -- to start the process in a random available port.
            --         -- if you set a port in your debug configuration, its value will be
            --         -- assigned dynamically.
            --         port = "${port}",
            --         -- additional args to pass to dlv
            --         args = {},
            --         -- the build flags that are passed to delve.
            --         -- defaults to empty string, but can be used to provide flags
            --         -- such as "-tags=unit" to make sure the test suite is
            --         -- compiled during debugging, for example.
            --         -- passing build flags using args is ineffective, as those are
            --         -- ignored by delve in dap mode.
            --         -- avaliable ui interactive function to prompt for arguments get_arguments
            --         build_flags = {},
            --         -- whether the dlv process to be created detached or not. there is
            --         -- an issue on delve versions < 1.24.0 for Windows where this needs to be
            --         -- set to false, otherwise the dlv server creation will fail.
            --         -- avaliable ui interactive function to prompt for build flags: get_build_flags
            --         detached = vim.fn.has("win32") == 0,
            --         -- the current working directory to run dlv from, if other than
            --         -- the current working directory.
            --         cwd = nil,
            --     }
            -- }
        )

            -- Setup dapui
            local dap, dapui = require("dap"), require("dapui")
            dapui.setup({
                layouts = {
                    {
                        elements = {
                            { id = "scopes", size = 0.25 },
                            "breakpoints",
                            "stacks",
                            "watches",
                        },
                        size = 40,
                        position = "left",
                    },
                    {
                        elements = {
                            "repl",
                            "console",
                        },
                        size = 0.25,
                        position = "bottom",
                    },
                },
            })

            -- Auto-open/close dapui
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
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
