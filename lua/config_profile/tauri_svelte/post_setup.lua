require('constant')

require('nvim-treesitter.configs').setup({
    ensure_installed = { "rust", "svelte", "javascript", "typescript", "html", "css" }, -- Add any other languages you need
    highlight = { enable = true },
    indent = { enable = true },
    folding = { enable = true, method = 'syntax' }, -- Enable folding based on Treesitter
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true)
        end
    end,
})

vim.lsp.enable('rust_analyzer')
vim.lsp.enable('svelte')
vim.lsp.enable('cssls')
vim.lsp.enable('html-lsp')
vim.lsp.enable('tailwindcss-language-server')
