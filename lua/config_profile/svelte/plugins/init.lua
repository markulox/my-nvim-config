return {
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

            -- Setup tailwind css language server
            vim.lsp.config('tailwindcss-language-server', {})
        end
    },
}

