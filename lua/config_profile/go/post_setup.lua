require('nvim-treesitter.configs').setup({
    ensure_installed = { "go" },
    sync_install = true,
    highlight = { enable = true },
    indent = { enable = true },
    folding = { enable = true, method = 'syntax' },
})

vim.lsp.enable('gopls')
