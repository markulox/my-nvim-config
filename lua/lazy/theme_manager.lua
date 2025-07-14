local is_dark_mode = true

-- Check theme colorscheme base on specific OS
local os_name = vim.loop.os_uname().sysname
if os_name == "Darwin" then
  local handle = io.popen(
  'osascript -e "tell application \\"System Events\\" to tell appearance preferences to return dark mode"')
  is_dark_mode = handle:read("*a")
  handle:close()
end

-- Theme management
local selected_theme = ""
local selected_airline_theme = ""
local selected_scrollbar_color = ""
if is_dark_mode:match("true") then
  selected_theme = _G.theme.dark
  selected_airline_theme = _G.theme.airline.dark
  selected_scrollbar_color = _G.theme.scrollbar_color.dark
else
  selected_theme = _G.theme.light
  selected_airline_theme = _G.theme.airline.light
  selected_scrollbar_color = _G.theme.scrollbar_color.light
end

-- CHeck package existance?
require("themer").setup({
  colorscheme = selected_theme,
  transparent = _G.theme.transparent_background,
  styles = {
    ["function"]    = { style = 'italic' },
    functionbuiltin = { style = 'italic' },
    variable        = { style = 'italic' },
    variableBuiltIn = { style = 'italic' },
    parameter       = { style = 'italic' },
    typeBuiltIn     = { style = 'bold' },
    keyword         = { style = 'bold' },
    keywordBuiltIn  = { style = 'bold' },
  },
})

require("scrollbar").setup({
  handle = {
    color = selected_scrollbar_color,
  },
})

vim.g['airline_theme'] = selected_airline_theme
vim.cmd("AirlineRefresh")

