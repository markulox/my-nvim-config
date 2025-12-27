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
