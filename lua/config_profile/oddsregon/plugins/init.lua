return {
  { -- For TS syntax hilight
    "sheerun/vim-polyglot"
  },
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      completion = {
        crates = {
          enabled = true,
        },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function(_, opts)
      require('mason').setup()
      require('mason-lspconfig').setup({
        ensure_installed = {
          "angularls",
          "ts_ls",
          "html",
          "cssls"
        },
        automatic_installation = true,
      })

      local lspconfig = require("lspconfig")
      -- Setup html language server
      lspconfig.html.setup({
        filetypes = { "html" },
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })

      -- Setup css language server
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      lspconfig.cssls.setup({
        capabilities = capabilities,
        cmd = { "vscode-css-language-server", "--stdio" },
        filetypes = { "css", "scss", "less" },
        init_options = {
          provideFormatter = true
        },
        settings = {
          css = {
            validate = true
          },
          less = {
            validate = true
          },
          scss = {
            validate = true
          }
        },
        single_file_support = true
      })

      -- Setup rust_analyzer language server
      lspconfig.rust_analyzer.setup({
        settings = {
          ["rust-analyzer"] = {
            imports = {
              granularity = { group = "module" },
              prefix = "self",
            },
            cargo = {
              allFeatures = true,
              buildScripts = {
                enable = true
              }
            },
            checkOnSave = { command = "clippy" },
            diagnostics = { enable = true },
            inlayHints = { enable = true }
          }
        }
      })
    end,
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    opts = {
      adapters = {
        ["rustaceanvim.neotest"] = {},
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",  -- Buffer completion
      "hrsh7th/cmp-path",    -- Path completion
      "hrsh7th/cmp-cmdline", -- Command-line completion
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    opts = function()
      local cmp = require("cmp")
      return {
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      }
    end
  },
}
