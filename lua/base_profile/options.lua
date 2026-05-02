-- Theme name configs
_G.theme = {
    light = "markulox_light",
    dark = "markulox_dark",
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
-- vim.opt.cursorcolumn = true

-- UI config
vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
    callback = function()
        if vim.bo.buftype == "" then
            vim.wo.number = true         -- add numbers to each line on the left side on local window
            vim.wo.relativenumber = true -- show absolute number on local window
        end
    end,
})
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

-- Custom statusline layout: mode | filetype | filename || branch | warn | error | line:col/total
vim.g.airline_section_b = '%{airline#util#wrap(airline#extensions#branch#get_head(),80)}'
vim.g.airline_section_c = '%f%m'
vim.g.airline_section_x = '%{&filetype}'
vim.g.airline_section_y = '%{airline#util#wrap(airline#extensions#nvimlsp#get_warning(),0)} %{airline#util#wrap(airline#extensions#nvimlsp#get_error(),0)}'
vim.g.airline_section_z = '%l:%c/%L'
vim.g.airline_section_error = ''
vim.g.airline_section_warning = ''

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
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = "always",
    },
})
