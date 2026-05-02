require('constant')

require('nvim-treesitter').install({ "rust", "svelte", "javascript", "typescript", "html", "css" })

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
