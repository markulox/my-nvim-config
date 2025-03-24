return {
    { "vim-airline/vim-airline" },
    { "vim-airline/vim-airline-themes" },
    {
        "nvim-telescope/telescope.nvim",
        -- tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local telescope = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", telescope.find_files, { silent = true })
            vim.keymap.set("n", "<leader>fd", telescope.lsp_definitions, { silent = true })
            vim.keymap.set("n", "<leader>fr", telescope.lsp_references, { silent = true })
            vim.keymap.set("n", "<leader>fs", telescope.lsp_document_symbols, { silent = true })
            vim.keymap.set("n", "<leader>fg", telescope.live_grep, { silent = true })

            require("telescope").setup({
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
            sort = {
                sorter = "case_sensitive",
            },
            view = {
                width = 30,
            },
            renderer = {
                group_empty = true,
            },
            filters = {
                dotfiles = false,
            },
        }
    },
    { "nvim-treesitter/nvim-treesitter" },
    { "j-hui/fidget.nvim" },
    { 
        "windwp/nvim-autopairs", 
        config = function()
            require("nvim-autopairs").setup{}
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
    }
}
