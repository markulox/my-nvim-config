return {
    { "vim-airline/vim-airline" },
    { "vim-airline/vim-airline-themes" },
    {
        "nvim-telescope/telescope.nvim",
        -- tag = '0.1.8',
        dependencies = {
            -- 'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
            -- 'nvim-telescope/telescope-media-files.nvim'
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

            local telescope = require("telescope")
            -- telescope.load_extension('media_files')
            telescope.setup({
                defaults = {
                    layout_strategy = "flex",
                    layout_config = {
                        height = 0.92,
                        width = 0.93,
                        prompt_position = "top",
                        --preview_cutoff = 0.1
                    },
                    --theme = "dropdown",
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
            api.config.mappings.default_on_attach(bufnr)
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
                width = 75,
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
    { "nvim-treesitter/nvim-treesitter" },
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
        config = function()
            require("dapui").setup()
            require("nvim-dap-virtual-text").setup()
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
        "JasinskiRafal/viu.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "m00qek/baleia.nvim"
        },
        opts = {}
    },
    {}
}
