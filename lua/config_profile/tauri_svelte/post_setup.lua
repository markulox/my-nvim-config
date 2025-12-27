require('constant')

require('nvim-treesitter.configs').setup({
    ensure_installed = { "rust" }, -- Add any other languages you need
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

-- Setup dap
local dap = require("dap")
dap.adapters.lldb = {
    type = "executable",
    -- Please download the codelldb from https://github.com/vadimcn/codelldb
    command = LLDB_VSCODE,
    name = "lldb"
}

require("lazy.nvim_profile");
dap.configurations.rust = {
    {
        name = "Launch Rust Debug",
        type = "lldb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", Get_first_open_dir() .. "/target/debug/", "file")
        end,
        cwd = Get_first_open_dir(),
        stopOnEntry = false,
        args = {},
    }
}

vim.lsp.enable('rust_analyzer')
vim.lsp.enable('svelte')
vim.lsp.enable('cssls')
vim.lsp.enable('html-lsp')
