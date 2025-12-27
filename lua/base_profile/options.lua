-- Theme name configs
_G.theme = {
    light = "markulox_light",
    dark = "github_dark",
    transparent_background = true,
    airline = {
        dark = "base16_adwaita",
        light = "base16_one_light"
    },
    scrollbar_color = {
        dark = "#3a3a3a",
        light = "#ffffff"
    }
}

-- Hint: use `:h <option>` to figure out the meaning if needed
vim.opt.clipboard = 'unnamedplus' -- use system clipboard
vim.opt.completeopt = { 'menu', 'menuone', 'preview', 'noselect' }
vim.opt.mouse = 'a'               -- allow the mouse to be used in Nvim

-- Tab
vim.opt.tabstop = 4      -- number of visual spaces per TAB
vim.opt.softtabstop = 4  -- number of spacesin tab when editing
vim.opt.shiftwidth = 4   -- insert 4 spaces on a tab
vim.opt.expandtab = true -- tabs are spaces, mainly because of python

-- highlight
vim.opt.cursorcolumn = true

-- UI config
vim.opt.number = true     -- show absolute number
vim.opt.relativenumber = true       -- add numbers to each line on the left side
vim.opt.cursorline = true -- highlight cursor line underneath the cursor horizontally
vim.opt.splitbelow = true -- open new vertical split bottom
vim.opt.splitright = true -- open new horizontal splits right
-- vim.opt.termguicolors = true        -- enabl 24-bit RGB color in the TUI
vim.opt.showmode = false  -- we are experienced, wo don't need the "-- INSERT --" mode hint

-- Searching
vim.opt.incsearch = true  -- search as characters are entered
vim.opt.hlsearch = true   -- highlight matches
vim.opt.ignorecase = true -- ignore case in searches by default
vim.opt.smartcase = true  -- but make it case sensitive if an uppercase is entered

-- Text warp
vim.wo.wrap = false

-- Shortcut keymap
vim.api.nvim_set_keymap('n', '<C-b>', ':NvimTreeToggle<CR>', { noremap = true, silent = true, desc = "Toggle nvim-tree" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action (Quick Fix)" })
vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, { desc = "Format this file" })

-- Example configuration in Lua for Neovim
vim.g['airline_theme'] = 'dark'
-- vim.g['airline#extensions#tabline#enabled'] = 0
vim.g['airline#extensions#git#enabled'] = 1

-- Dap configuration
vim.keymap.set("n", "<F5>", ":DapContinue<CR>", { silent = true, desc = "Debug: Continue" })
vim.keymap.set("n", "<F10>", ":DapStepOver<CR>", { silent = true, desc = "Debug: Step over" })
vim.keymap.set("n", "<F11>", ":DapStepInto<CR>", { silent = true, desc = "Debug: Step into" })
vim.keymap.set("n", "<F12>", ":DapStepOut<CR>", { silent = true, desc = "Debug: Step out" })
vim.keymap.set("n", "<Leader>b", ":DapToggleBreakpoint<CR>", { silent = true, desc = "Debug: Toggle break point" })
vim.keymap.set("n", "<Leader>dr", ":DapRestartFrame<CR>", { silent = true, desc = "Debug: Restart frame" })
vim.keymap.set("n", "<Leader>dl", ":lua require('dap').run_last()<CR>", { silent = true, desc = "Debug: Last run" })

-- Window Management configuration
vim.keymap.set("n", "<Leader><Left>", "<C-w>h")
vim.keymap.set("n", "<Leader><Right>", "<C-w>l")
vim.keymap.set("n", "<Leader><Up>", "<C-w>k")
vim.keymap.set("n", "<Leader><Down>", "<C-w>j")

-- EZ-LSP Rename
vim.keymap.set('n', '<leader>rn', function()
    local current_word = vim.fn.expand('<cword>')
    local new_name = vim.fn.input('New name: ', current_word)
    if new_name ~= '' and new_name ~= current_word then
        vim.lsp.buf.rename(new_name)
    end
end, { desc = 'LSP Rename' })

-- Show diagnostic function
vim.diagnostic.config({
    virtual_text = {
        prefix = '▶', -- '●', '■', '▶', '', etc.
        spacing = 0,
        only_current_line = false,
    },
    --virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = "always",
    },
})
