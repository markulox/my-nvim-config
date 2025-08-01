-- Add to your config
_G.theme.dark = "gruvbox"

-- Debug config
require('config_profile.swift_app.debug_options')
vim.keymap.set("n", "<leader>dd", Xcodebuild.build_and_debug, { desc = "Build & Debug" })
vim.keymap.set("n", "<leader>dr", Xcodebuild.debug_without_build, { desc = "Debug Without Building" })
vim.keymap.set("n", "<leader>dt", Xcodebuild.debug_tests, { desc = "Debug Tests" })
vim.keymap.set("n", "<leader>dT", Xcodebuild.debug_class_tests, { desc = "Debug Class Tests" })
vim.keymap.set("n", "<leader>b", Xcodebuild.toggle_breakpoint, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<leader>B", Xcodebuild.toggle_message_breakpoint, { desc = "Toggle Message Breakpoint" })
vim.keymap.set("n", "<leader>dx", Xcodebuild.terminate_session, { desc = "Terminate Debugger" })
