return {
  "nvim-telescope/telescope.nvim",
  keys = {
    {
      "<leader>sf",
      function()
        require("telescope.builtin").live_grep({
          additional_args = function()
            return { "--fixed-strings" }
          end,
        })
      end,
      desc = "Grep (literal/fixed string)",
    },
  },
}
