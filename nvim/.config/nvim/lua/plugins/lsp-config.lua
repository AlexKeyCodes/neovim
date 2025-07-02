return {
  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Ruby Language Server
        ruby_lsp = {
          mason = true,
          settings = {
            rubyLsp = {
              enabledFeatures = {
                --"codeActions",
                "diagnostics",
                "documentHighlights",
                "documentSymbols",
                "foldingRanges",
                "formatting",
                "hover",
                --"inlayHints",
                "selectionRanges",
                "semanticHighlighting",
                --"completion",
              },
            },
          },
        },
        -- HTML Language Server (for .html.erb files)
        html = {
          mason = true,
          filetypes = { "html", "eruby" },
          settings = {
            html = {
              format = {
                templating = true,
                wrapLineLength = 120,
                wrapAttributes = "auto",
              },
            },
          },
        },
        -- CSS Language Server
        cssls = {
          mason = true,
          filetypes = { "css", "scss", "sass" },
        },
        -- JavaScript Language Server (for .js files)
        eslint = {
          mason = true,
          settings = {
            workingDirectories = { mode = "auto" },
            format = { enable = true },
            rules = {
              quotes = { "error", "single" },
              semi = { "error", "never" },
            },
          },
        },
      },
    },
  },
  -- Mason tool installer
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- Ruby tools
        "ruby-lsp",
        "rubocop",
        -- Web tools
        "html-lsp",
        "css-lsp",
        "eslint_d",
        "prettier",
      },
    },
  },
  -- Treesitter for syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "ruby",
        "html",
        "embedded_template", -- for ERB templates
        "css",
        "scss",
        "javascript",
        "json",
        "yaml",
        "bash",
        "lua",
        "vim",
        "markdown",
      },
    },
  },
  -- Rails-specific plugins
  {
    "tpope/vim-rails",
    ft = { "ruby", "eruby" },
    config = function()
      -- Rails-specific keymaps
      vim.keymap.set("n", "<leader>ra", ":A<CR>", { desc = "Rails Alternate" })
      vim.keymap.set("n", "<leader>rr", ":R<CR>", { desc = "Rails Related" })
      vim.keymap.set("n", "<leader>rm", ":Emodel<CR>", { desc = "Rails Model" })
      vim.keymap.set("n", "<leader>rc", ":Econtroller<CR>", { desc = "Rails Controller" })
      vim.keymap.set("n", "<leader>rv", ":Eview<CR>", { desc = "Rails View" })
    end,
  },
  {
    "tpope/vim-bundler",
    ft = { "ruby" },
  },
  -- Ruby syntax and indentation
  {
    "vim-ruby/vim-ruby",
    ft = { "ruby", "eruby" },
  },
  -- Formatting
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ruby = { "rubocop" },
        html = { "prettier" },
        css = { "prettier" },
        javascript = { "prettier" },
        json = { "prettier" },
      },
      formatters = {
        prettier = {
          prepend_args = {
            "--single-quote",
            "--no-semi",
            "--trailing-comma",
            "es5",
          },
        },
      },
    },
  },
  vim.filetype.add({
    extension = {
      njk = "html",
    },
  }),
}
