-- Enter between a pair — brackets `(|)`, `{|}`, `[|]` or tags `<div>|</div>` —
-- puts the closing half on its own line and the cursor on an indented line
-- between them. Indentation is set explicitly (one level deeper than the
-- opening line) instead of trusting the indent guess, which is often wrong
-- mid-edit while the syntax tree is still incomplete (e.g. JSX in `return (`).
--
-- In Ruby, Enter at the end of a line that opens a block (`def`, `class`,
-- `if`, `do`, ...) also adds the matching `end` below, cursor staying on the
-- indented line in between.

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

local ruby_openers = { "module", "class", "def", "if", "unless", "case", "while", "until", "for", "begin" }
local ruby_continuations = { "end", "else", "elsif", "when", "in", "rescue", "ensure" }

local function starts_with_word(text, words)
  for _, word in ipairs(words) do
    if text:match("^" .. word .. "%f[^%w_]") then
      return true
    end
  end
  return false
end

-- True when `line` opens a Ruby block that still needs an `end`.
local function ruby_opens_block(line)
  local text = line:gsub("^%s*", "")
  if text:match("^#") or text:match("%f[%w_]end%f[^%w_]") then
    return false -- comment, or a one-liner like `def foo; end`
  end
  -- Endless method: `def foo = 1` / `def foo(x) = x * 2` (but not `def foo=(v)`).
  if text:match("def%s+[%w_%.?!]+%b()%s*=") or text:match("def%s+[%w_%.?!]+%s+=%s") then
    return false
  end
  if text:match("%f[%w_]do%s*$") or text:match("%f[%w_]do%s*|[^|]*|%s*$") then
    return true
  end
  -- `private def foo`, `x = if cond`, `@y ||= begin`
  local rest = text:match("^[%l_]+%s+(def%f[^%w_].*)") or text:match("[^=!<>]=%s*(%l+%f[^%w_].*)$") or text
  return starts_with_word(rest, ruby_openers)
end

-- True when the block opened on `lnum` already has its `end` (or an
-- `else`/`rescue`/... branch): the next line at or left of its indent is one
-- of those keywords at exactly the same indent.
local function ruby_block_closed(lnum)
  local base = vim.fn.indent(lnum)
  for l = lnum + 1, vim.fn.line("$") do
    local line = vim.fn.getline(l)
    if line:match("%S") and vim.fn.indent(l) <= base then
      return vim.fn.indent(l) == base and starts_with_word(line:gsub("^%s*", ""), ruby_continuations)
    end
  end
  return false
end

-- Runs right after Enter on a block-opening line: cursor is on the new line.
_G.AutoIndentAddEnd = function()
  local lnum = vim.fn.line(".")
  local base = vim.fn.indent(lnum - 1)
  vim.fn.append(lnum, indent_str(base) .. "end")
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
      local add_end = t("<Cmd>lua AutoIndentAddEnd()<CR>")

      pairs.cr = function(...)
        local line = vim.api.nvim_get_current_line()
        local col = vim.api.nvim_win_get_cursor(0)[2]
        local before, after = line:sub(1, col), line:sub(col + 1)
        if between_tags(before, after) then
          return split .. fix
        end
        local keys = cr(...)
        if
          vim.bo.filetype == "ruby"
          and not after:match("%S")
          and ruby_opens_block(before)
          and not ruby_block_closed(vim.fn.line("."))
        then
          return keys .. add_end
        end
        if keys:sub(-#open_above) == open_above then
          return keys .. fix
        end
        return keys
      end
    end,
  },
}
