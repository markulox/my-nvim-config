local rust_plugins = require('config_profile.rust_dev.plugins.init')
local svelte_plugins = require('config_profile.svelte.plugins.init')

for _, each_svelte_plugin in ipairs(svelte_plugins) do
    table.insert(rust_plugins, each_svelte_plugin)
end

return rust_plugins

