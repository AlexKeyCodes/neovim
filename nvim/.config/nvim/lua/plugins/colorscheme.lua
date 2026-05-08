return {
  -- add catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      transparent_background = true,
    },
  },
  {
    "navarasu/onedark.nvim",
    priority = 1000,
    opts = {
      style = "darker", -- dark, darker, cool, deep, warm, warmer
      transparent = true,
    },
  },
  {
    "nyoom-engineering/oxocarbon.nvim",
    priority = 1000,
  },
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    opts = {
      transparent = true,
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  { "Mofiqul/dracula.nvim" },
  -- Configure LazyVim to load your preferred default theme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin", --Change value to load different theme
    },
  },
}
