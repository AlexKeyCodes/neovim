-- Enter between a pair — brackets `(|)`, `{|}`, `[|]` or tags `<div>|</div>` —
-- puts the closing half on its own line and the cursor on an indented line
-- between them. Indentation is set explicitly (one level deeper than the
-- opening line) instead of trusting the indent guess, which is often wrong
-- mid-edit while the syntax tree is still incomplete (e.g. JSX in `return (`).

local function indent_str(width)
  if vim.bo.expandtab then
    return string.rep(" ", width)
  end
  local ts = vim.bo.tabstop
  return string.rep("\t", math.floor(width / ts)) .. string.rep(" ", width % ts)
end

local function set_indent(lnum, width)
  local line = vim.fn.getline(lnum)
  vim.fn.setline(lnum, indent_str(width) .. line:gsub("^%s*", ""))
end

-- True when the cursor sits between an opening tag and its own closing tag,
-- e.g. `<div className="a">|</div>` or `<>|</>`. Deliberately false after a
-- closing tag (`</span>|</div>`), a self-closing tag (`<br />|</div>`) or an
-- ERB tag (`<%= x %>|</p>`), where a plain Enter is what's wanted.
local function between_tags(before, after)
  local close_name = after:match("^%s*</([%w%.%-:_]*)%s*>")
  if not close_name or not before:match(">%s*$") or before:match("[/%%]>%s*$") then
    return false
  end
  -- Last thing in `before` that starts a tag: `<name`, `</name` or `<>`.
  local last
  for pos in before:gmatch("()<[/%a>]") do
    last = pos
  end
  if not last or before:sub(last + 1, last + 1) == "/" then
    return false
  end
  return before:match("^<([%w%.%-:_]*)", last) == close_name
end

-- Runs right after the split: cursor is on the new middle line.
_G.AutoIndentFixSplit = function()
  local lnum = vim.fn.line(".")
  local base = vim.fn.indent(lnum - 1)
  set_indent(lnum + 1, base)
  set_indent(lnum, base + vim.fn.shiftwidth())
  vim.api.nvim_win_set_cursor(0, { lnum, #vim.fn.getline(lnum) })
end

return {
  {
    "nvim-mini/mini.pairs",
    config = function(_, opts)
      LazyVim.mini.pairs(opts)

      local pairs = require("mini.pairs")
      local cr = pairs.cr
      local t = function(s)
        return vim.api.nvim_replace_termcodes(s, true, true, true)
      end
      local split = t("<CR><C-o>O")
      local open_above = t("<C-o>O")
      local fix = t("<Cmd>lua AutoIndentFixSplit()<CR>")

      pairs.cr = function(...)
        local line = vim.api.nvim_get_current_line()
        local col = vim.api.nvim_win_get_cursor(0)[2]
        local before, after = line:sub(1, col), line:sub(col + 1)
        if between_tags(before, after) then
          return split .. fix
        end
        local keys = cr(...)
        if keys:sub(-#open_above) == open_above then
          return keys .. fix
        end
        return keys
      end
    end,
  },
}
