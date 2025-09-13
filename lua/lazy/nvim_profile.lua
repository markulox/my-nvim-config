Arg_path = nil

function Get_first_open_dir()
    if Arg_path == nil then
        Arg_path = vim.fn.argv(0) or vim.fn.getcwd()
        if string.sub(Arg_path, 1, 1) ~= "/" then
            Arg_path = vim.fn.getcwd() .. "/" .. Arg_path
        end
    end
    return Arg_path
end

function Get_profile_name()
    local f = io.open(Get_first_open_dir() .. "/.nvim/profile", "r")
    if f then
        local profile_name = f:read("l");
        f:close();
        return profile_name;
    else
        return os.getenv("NVIM_PROFILE");
    end
end

vim.api.nvim_create_user_command("ProfileSet", function(opts)
    local profile_name = opts.fargs[1]
    local home_dir = vim.fn.expand("~/")
    local profile_path = home_dir .. "/.config/nvim/lua/config_profile/" .. profile_name
    if vim.fn.isdirectory(profile_path) == 1 then
        os.execute("mkdir " .. Get_first_open_dir() .. "/.nvim")
        local f = io.open(Get_first_open_dir() .. "/.nvim/profile", "w")
        if f then
            f:write(profile_name)
            f:close()
            vim.notify("[NVIM PROFILE]: Please restart nvim to apply changes")
        else
            vim.notify("[NVIM PROFILE]: Can't create .nvim/profile", vim.log.levels.ERROR)
        end
    else
        vim.notify(
            "[NVIM PROFILE]: Profile " ..
            profile_name ..
            " is not yet created. Consider using command \"ProfileCreate " .. profile_name .. "\" to create the profile.",
            vim.log.levels.ERROR)
    end
end, {
    nargs = 1
})


vim.api.nvim_create_user_command("ProfileCreate", function(opts)
    local profile_name = opts.fargs[1]
    local home_dir = vim.fn.expand("~/")
    local profile_path = home_dir .. ".config/nvim/lua/config_profile/" .. profile_name
    local plugins_path = profile_path .. "/plugins"

    if vim.fn.isdirectory(profile_path) == 1 then
        vim.notify(profile_path)
        vim.notify("[NVIM PROFILE]: Profile \"" .. profile_name .. "\" already exists!", vim.log.levels.ERROR)
        return
    end

    os.execute("mkdir -p " .. plugins_path)
    local plugins_file = io.open(plugins_path .. "/init.lua", "w")
    if plugins_file then
        plugins_file:write("return {}")
        plugins_file:close()
    else
        vim.notify("[NVIM PROFILE]: Can't create \"init.lua\" in " .. plugins_path, vim.log.levels.ERROR)
    end

    local options_file = io.open(profile_path .. "/options.lua", "w")
    if options_file then
        options_file:close()
    else
        vim.notify("[NVIM PROFILE]: Can't create \"options.lua\" in " .. profile_path, vim.log.levels.ERROR)
    end

    local post_setup_file = io.open(profile_path .. "/post_setup.lua", "w")
    if post_setup_file then
        post_setup_file:close()
    else
        vim.notify("[NVIM PROFILE]: Can't create \"post_setup.lua\" in " .. profile_path, vim.log.levels.ERROR)
    end

    vim.notify("[NVIM PROFILE]: Profile \"" .. profile_name .. "\" created.")
end, {
    nargs = 1
})

vim.api.nvim_create_user_command("ProfileList", function()
    local home_dir = vim.fn.expand("~/")
    local profile_path = home_dir .. ".config/nvim/lua/config_profile/"

    vim.notify("[NVIM PROFILE]: List of available profiles.")
    local iter = vim.loop.fs_scandir(profile_path)
    while iter do
        local name, type = vim.loop.fs_scandir_next(iter)
        if not name then break end
        vim.notify(" - " .. name)
    end
end, {
    nargs = 0
})
