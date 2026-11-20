-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
-- Custom highlights for oxocarbon theme with Snacks.nvim
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "oxocarbon",
  callback = function()
    local colors = {
      base09 = "#78a9ff", -- bright blue - for folder text
      base04 = "#dde1e6", -- light text
      base15 = "#82cfff", -- light blue for matches
      base10 = "#ee5396", -- hot pink/magenta! - for folder icons
    }

    -- Folder text
    vim.api.nvim_set_hl(0, "SnacksPickerDir", { fg = colors.base09, bold = true })
    vim.api.nvim_set_hl(0, "SnacksPickerFile", { fg = colors.base04 })
    vim.api.nvim_set_hl(0, "SnacksPickerMatch", { fg = colors.base15, bold = true })
    vim.api.nvim_set_hl(0, "Directory", { fg = colors.base09, bold = true })

    -- TARGET MINI.ICONS SPECIFICALLY!
    vim.api.nvim_set_hl(0, "MiniIconsAzure", { fg = colors.base10 })

    -- Also target the directory specific ones
    vim.api.nvim_set_hl(0, "MiniIconsDirectory", { fg = colors.base10 })
    vim.api.nvim_set_hl(0, "MiniIconsFile", { fg = colors.base04 })
  end,
})
