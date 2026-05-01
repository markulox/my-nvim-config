return {
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls" },
                automatic_installation = true,
            })
            vim.lsp.config('lua_ls', {
                cmd = { "lua-language-server" },
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = {
                            enable = false,
                        },
                    },
                },
                root_markers = {
                    ".luarc.json", ".luarc.jsonc", ".luacheckrc",
                    ".stylua.toml", "stylua.toml", "selene.toml", "selene.yml", ".git"
                },
            })
        end
    },
}
