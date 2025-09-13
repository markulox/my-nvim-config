-- require('nvim-treesitter.configs').setup({
--     ensure_installed = { "zig", "ziggy", "ziggy_schema" }, -- Add any other languages you need
--     highlight = { enable = true },
--     indent = { enable = true },
--     folding = { enable = true, method = 'syntax' }, -- Enable folding based on Treesitter
-- })

-- Setup dap
local dap = require("dap")
dap.adapters.lldb = {
    type = "executable",
    -- Please download the codelldb from https://github.com/vadimcn/codelldb
    command = vim.fn.expand("~/.config/nvim/extensions/vadimcn.codelldb.v1.11.4/adapter/codelldb"), -- Update with the correct path!
    name = "lldb"
}

require("lazy.nvim_profile");
dap.configurations.zig = {
    {
        name = "Launch Zig Debug",
        type = "lldb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", Get_first_open_dir() .. "/zig-out/bin/", "file")
        end,
        cwd = Get_first_open_dir(),
        stopOnEntry = false,
        args = {},
    }
}
