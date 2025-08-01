-- Add to your config
_G.theme.dark = "gruvbox"

local function swift_build()
  vim.cmd('!swift build')
  vim.cmd('!swift package resolve')
end
vim.api.nvim_create_user_command('Build', swift_build, {})
vim.api.nvim_create_user_command('Sb', swift_build, {})

local function swift_run()
  vim.cmd('!swift run')
end
vim.api.nvim_create_user_command('Run', swift_run, {})
vim.api.nvim_create_user_command('Sr', swift_run, {})

local function swift_test()
  vim.cmd('!swift test')
end
vim.api.nvim_create_user_command('Test', swift_test, {})
vim.api.nvim_create_user_command('St', swift_test, {})

require('config_profile.swift.debug_options')
