require('nvim-treesitter.configs').setup({
    ensure_installed = { "svelte", "javascript", "typescript", "html", "css" }, -- Add any other languages you need
    highlight = { enable = true },
    indent = { enable = true },
    folding = { enable = true, method = 'syntax' }, -- Enable folding based on Treesitter
})

vim.lsp.enable('svelte')
vim.lsp.enable('cssls')
vim.lsp.enable('html-lsp')
vim.lsp.enable('tailwindcss-language-server')

