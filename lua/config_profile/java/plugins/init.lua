return {
    {
        'nvim-java/nvim-java',
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
        },
        config = function()
            require('mason').setup()
            require('mason-lspconfig').setup({
                ensure_installed = {
                    'jdtls',
                },
                automatic_installation = true
            })
            -- require('java').setup()
            require('lspconfig').jdtls.setup({})
        end
    },
}
