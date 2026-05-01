Arg_path = nil

local function _get_first_open_dir()
    if Arg_path == nil then
        Arg_path = vim.fn.argv(0) or vim.fn.getcwd()
        if string.sub(Arg_path --[[@as string]], 1, 1) ~= "/" then
            Arg_path = vim.fn.getcwd() .. "/" .. Arg_path
        end
    end
    return Arg_path
end

local function _get_profile_name()
    local f = io.open(_get_first_open_dir() .. "/.nvim/profile", "r")
    if f then
        local profile_name = f:read("l");
        f:close();
        return profile_name;
    else
        return os.getenv("NVIM_PROFILE");
    end
end

return {
    Get_first_open_dir = _get_first_open_dir,
    Get_profile_name = _get_profile_name,
}
