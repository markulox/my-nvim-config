-- LSP setup

require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = {
        "yamlls",
        "tombi",
        "jsonls"
    },
    automatic_installation = true
})


vim.lsp.enable('jsonls')
vim.lsp.enable('yamlls')
vim.lsp.enable('tombi')
