-- Completion stays out of the way: the menu never opens on its own, so Enter
-- is always a plain new line. Press <C-Space> to open it on demand (Emmet
-- abbreviations, method names, ...), then <C-n>/<C-p> to pick and Enter or
-- <C-y> to accept. Signature help and `K` hover docs are unaffected.
return {
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        menu = { auto_show = false },
        ghost_text = { enabled = false },
        -- Nothing is selected until you move onto an item, so Enter only
        -- accepts a completion you explicitly picked.
        list = { selection = { preselect = false, auto_insert = true } },
      },
    },
  },
}
