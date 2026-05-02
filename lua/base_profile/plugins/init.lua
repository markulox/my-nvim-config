return {
    {
        "vim-airline/vim-airline",
        init = function()
            vim.g.airline_mode_map = {
                -- ['__']    = '-',
                ['c']     = '⌘',
                ['i']     = 'I',
                -- ['ic']    = 'IC',
                -- ['ix']    = 'IX',
                ['n']     = 'N',
                -- ['multi'] = 'M',
                -- ['ni']    = 'NI',
                -- ['no']    = 'NO',
                -- ['R']     = 'R',
                -- ['Rv']    = 'RV',
                -- ['s']     = 's',
                -- ['S']     = 'S',
                -- ['']     = '^S',
                -- ['t']     = 'T',
                ['v']     = 'Vis',
                ['V']     = '-V-',
                ['']     = '[V]',
            }
        end
    },
    { "vim-airline/vim-airline-themes" },
    {
        "nvim-telescope/telescope.nvim",
        -- tag = '0.1.8',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        config = function()
            local telescope_builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, { silent = true, desc = "Find files" })
            vim.keymap.set("n", "<leader>fd", telescope_builtin.lsp_definitions,
                { silent = true, desc = "Find LSP definitions" })
            vim.keymap.set("n", "<leader>fr", telescope_builtin.lsp_references,
                { silent = true, desc = "Find LSP references" })
            vim.keymap.set("n", "<leader>fs", telescope_builtin.lsp_document_symbols,
                { silent = true, desc = "Find LSP symbols" })
            vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep,
                { silent = true, desc = "Find patterns (Grep)" })
            vim.keymap.set("n", "<leader>fk", telescope_builtin.keymaps, { silent = true, desc = "Find keymaps" })
            vim.keymap.set("n", "<leader>fe", telescope_builtin.diagnostics, { silent = true, desc = "Find errors (diagnostics)" })

            local telescope = require("telescope")
            -- telescope.load_extension('media_files')
            telescope.setup({
                defaults = {
                    layout_strategy = "flex",
                    layout_config = {
                        height = 0.92,
                        width = 0.93,
                        prompt_position = "top",
                    },
                },
                pickers = {
                    find_files = {
                        layout_strategy = "flex",
                        layout_config = {
                            width = 0.9,
                            height = 0.9,
                            prompt_position = "top",
                        },
                    },
                    live_grep = {
                        layout_strategy = "vertical",
                    },
                },
                -- extensions = {
                --     media_files = {
                --         -- filetypes whitelist
                --         -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
                --         filetypes = { "png", "webp", "jpg", "jpeg", "pdf" },
                --         -- find command (defaults to `fd`)
                --         -- find_cmd = "rg"
                --     }
                -- },
            })
        end
    },
    {
        "nvim-tree/nvim-tree.lua",
        on_attach = function(bufnr)
            local api = require("nvim-tree.api")
            api.map.on_attach.default(bufnr)
        end,
        opts = {
            diagnostics = {
                enable = true,
                show_on_dirs = true,
            },
            sort = {
                sorter = "case_sensitive",
            },
            view = {
                width = {
                    min = 10,
                    max = 55,
                    padding = 1,
                },
                relativenumber = true
            },
            renderer = {
                group_empty = true,
            },
            filters = {
                dotfiles = false,
            },
            update_focused_file = {
                enable = true,
                update_root = false,
                ignore_list = {},
            },
            modified = {
                enable = true,
                show_on_open_dirs = false,
            }
        }
    },
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require('nvim-treesitter').install({
                "bash", "yaml", "markdown", "markdown_inline",
                "json", "json5", "toml", "html", "css", "javascript", "lua",
            })
        end,
    },
    { "j-hui/fidget.nvim" },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup {}
        end
    },
    { "tpope/vim-fugitive" },
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "theHamsta/nvim-dap-virtual-text",
        },
        keys = {
            { "<F5>",      "<cmd>DapContinue<CR>",                       silent = true, desc = "Debug: Continue" },
            { "<F10>",     "<cmd>DapStepOver<CR>",                       silent = true, desc = "Debug: Step over" },
            { "<F11>",     "<cmd>DapStepInto<CR>",                       silent = true, desc = "Debug: Step into" },
            { "<F12>",     "<cmd>DapStepOut<CR>",                        silent = true, desc = "Debug: Step out" },
            { "<Leader>b", "<cmd>DapToggleBreakpoint<CR>",               silent = true, desc = "Debug: Toggle break point" },
            { "<Leader>dr","<cmd>DapRestartFrame<CR>",                   silent = true, desc = "Debug: Restart frame" },
            { "<Leader>dl", function() require("dap").run_last() end,    silent = true, desc = "Debug: Last run" },
        },
        config = function()
            require("dapui").setup()
            require("nvim-dap-virtual-text").setup({})
            local dap, dapui = require("dap"), require("dapui")
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end
    },
    { "themercorp/themer.lua" },
    { "petertriho/nvim-scrollbar" },
    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
        },
    },
    -- {
    --   "coder/claudecode.nvim",
    --   dependencies = { "folke/snacks.nvim" },
    --   config = true,
    --   keys = {
    --     { "<leader>a", nil, desc = "AI/Claude Code" },
    --     { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
    --     { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
    --     { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
    --     { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
    --     { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
    --     { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
    --     {
    --       "<leader>as",
    --       "<cmd>ClaudeCodeTreeAdd<cr>",
    --       desc = "Add file",
    --       ft = { "NvimTree", "neo-tree", "oil" },
    --     },
    --     -- Diff management
    --     { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    --     { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    --   },
    -- },
    {
        "3rd/image.nvim",
        build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
        ft = { "markdown", "norg", "org" },
        opts = {
            processor = "magick_cli",
        }
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
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
                    ["<CR>"]      = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"]     = cmp.mapping.select_next_item(),
                    ["<S-Tab>"]   = cmp.mapping.select_prev_item(),
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
