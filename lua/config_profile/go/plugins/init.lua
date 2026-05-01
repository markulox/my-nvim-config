return {
    -- Go development support
    {
        "fatih/vim-go",
        build = ":GoUpdateBinaries",
        config = function()
            vim.g.go_fmt_command = "gofumpt" -- Use gofumpt for formatting
            vim.g.go_imports_autosave = 1
            vim.g.go_def_mapping_enabled = 0
            vim.g.go_gopls_enabled = 0
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
    -- Debugging with Delve
    {
        "mfussenegger/nvim-dap",
        dependencies = { "leoluz/nvim-dap-go" },
        config = function()
            require("nvim-dap-virtual-text").setup()
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

            local function load_env(filepath)
                local env = {}
                local f = io.open(filepath, 'r')
                if not f then return env end
                for line in f:lines() do
                    local key, val = line:match('^([%w_]+)=(.+)$')
                    if key then
                        val = val:match('^"(.*)"$') or val:match("^'(.*)'$") or val
                        env[key] = val
                    end
                end
                f:close()
                return env
            end
            table.insert(dap.configurations.go, {
                type = 'go',
                name = 'Launch with .env',
                request = 'launch',
                program = '${file}',
                env = load_env(vim.fn.getcwd() .. '/.env'),
            })
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
}
