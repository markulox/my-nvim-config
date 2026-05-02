require('nvim-treesitter').install({ "svelte", "javascript", "typescript", "html", "css" })

vim.lsp.enable('svelte')
vim.lsp.enable('cssls')
vim.lsp.enable('html-lsp')
vim.lsp.enable('tailwindcss-language-server')

