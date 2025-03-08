
require('nvim-treesitter.configs').setup({
    ensure_installed = { "go" }, -- Add any other languages you need
    sync_install = true,
    highlight = { enable = true },
    indent = { enable = true },
    folding = { enable = true, method = 'syntax' }, -- Enable folding based on Treesitter
})