return {
  -- Git blame functionality (GitLens equivalent)
  {
    "f-person/git-blame.nvim",
    event = "BufReadPre",
    config = function()
      vim.cmd("highlight default link gitblame SpecialComment")
      vim.g.gitblame_enabled = 0 -- Start disabled, toggle with <leader>gb
      vim.g.gitblame_message_template = "<summary> • <date> • <author>"
      vim.g.gitblame_highlight_group = "NonText"
      vim.g.gitblame_display_virtual_text = 1
      
      -- Keymaps
      vim.keymap.set("n", "<leader>gb", ":GitBlameToggle<CR>", { desc = "Toggle Git Blame" })
      vim.keymap.set("n", "<leader>go", ":GitBlameOpenCommitURL<CR>", { desc = "Open Commit URL" })
    end,
  },
}