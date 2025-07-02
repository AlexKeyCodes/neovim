return {
  -- add catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
    },
  },
  {
    "navarasu/onedark.nvim",
    priority = 1000,
    opts = {
      style = "darker", -- dark, darker, cool, deep, warm, warmer
    },
  },
  -- Configure LazyVim to load your preferred default theme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin", --Change value to load different theme
    },
  },
}
