-- require("mason.nvim").setup()
-- require("mason-lspconfig.nvim").setup()

require('nvim-treesitter.configs').setup({
    ensure_installed = { "angular", "typescript" }, -- Add any other languages you need
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
    folding = { enable = true, method = 'syntax' }, -- Enable folding based on Treesitter
})