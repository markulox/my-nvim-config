-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Check existance of .nvim_profile
require("lazy.nvim_profile")
local nvim_profile = get_profile_name()
if not nvim_profile then
  vim.notify("[NVIM_PROFILE]: Using based profile.")
else
  vim.notify("[NVIM_PROFILE]: Using profile: \""..nvim_profile.."\"")
end

-- Setup lazy.nvim
local specs = {{ import = "base_profile/plugins" },}
if nvim_profile then
  table.insert(specs, { import = "config_profile/" .. nvim_profile .. "/plugins" })
end
require("lazy").setup({
  spec = specs,
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

require("base_profile.options") -- load default config
require("base_profile.post_setup") -- load default poset setup
if nvim_profile then -- if profile config detected
  require("config_profile.".. nvim_profile ..".options") -- load extra config for specific profile
  require("config_profile.".. nvim_profile .. ".post_setup") -- load post setup
end
require("base_profile.last_setup")