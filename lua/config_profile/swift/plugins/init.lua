return {
    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
        },
        config = function()
            require('mason').setup()
            require('mason-lspconfig').setup({
                automatic_installation = true,
            })
            vim.lsp.config('sourcekit', {
                capabilities = {
                    workspace = {
                        didChangeWatchedFiles = {
                            dynamicRegistration = true,
                        },
                    },
                },
                cmd = { "sourcekit-lsp" },
                filetypes = { "swift", "objective-c", "objective-cpp" },
                root_dir = vim.lsp.util.root_pattern("Package.swift", ".git"),
            })
        end,
    },
}
