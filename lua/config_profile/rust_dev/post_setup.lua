
require('nvim-treesitter.configs').setup({
    ensure_installed = { "rust" }, -- Add any other languages you need
    highlight = { enable = true },
    indent = { enable = true },
    folding = { enable = true, method = 'syntax' }, -- Enable folding based on Treesitter
})