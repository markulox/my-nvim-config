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
}
