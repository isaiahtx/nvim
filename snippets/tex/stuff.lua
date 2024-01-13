local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

-- Summary: When `LS_SELECT_RAW` is populated with a visual selection, the function
-- returns an insert node whose initial text is set to the visual selection.
-- When `LS_SELECT_RAW` is empty, the function simply returns an empty insert node.
local get_visual = function(args, parent)
  if #parent.snippet.env.LS_SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

return {
  s({
    trig = "ff",
    wordTrig = false,
    snippetType = "autosnippet",
  }, fmt("\\frac{<>}{<>}", { i(1), i(2) }, { delimiters = "<>" })),

  s(
    { trig = "bb", dscr = "Expands 'bb' into '\\mathbb{}'" },
    fmta("\\mathbb{<>}<>", { i(1), i(0) }, { delimiters = "<>" })
  ),

  s(
    { trig = "bf", dscr = "Expands 'bf' into '\\mathbf{}'" },
    fmta("\\mathbf{<>}<>", { i(1), i(0) }, { delimiters = "<>" })
  ),

  s(
    { trig = "al", dscr = "Expands 'al' into an align environment" },
    fmta(
      [[
        \begin{align*}
            <>
        \end{align*}
      ]],
      { i(1) }
    )
  ),

  s(
    { trig = "eq", dscr = "Expands 'eq' into an equation environment" },
    fmta(
      [[
        \begin{equation*}
            <>
        \end{equation*}
      ]],
      { i(1) }
    )
  ),

  s(
    { trig = "env", descr = "Expands 'env' into new '\\begin{}\\end{}'" },
    fmta(
      [[
        \begin{<>}
            <>
        \end{<>}
      ]],
      {
        i(1),
        i(2),
        rep(1), -- this node repeats insert node i(1)
      }
    )
  ),

  s(
    { trig = "lenv" },
    fmta(
      [[
        \begin{<>}\label{<>}
            <>
        \end{<>}
      ]],
      {
        i(1),
        i(2),
        i(3),
        rep(1), -- this node repeats insert node i(1)
      }
    )
  ),

  s(
    {
      trig = "hr",
      dscr = "The hyperref package's href{}{} command (for url links)",
    },
    fmta("\\href{<>}{<>}", {
      i(1, "url"),
      i(2, "display name"),
    })
  ),

  s({ trig = "(%a)(%d)", regTrig = true, hidden = true }, {
    d(1, function(_, snip)
      -- Capture the letter and number from the trigger
      local letter, number = snip.captures[1], snip.captures[2]
      -- Create a snippet node with the formatted string and an insert node
      return ls.sn(nil, {
        f(function()
          return letter .. "_{" .. number .. "}"
        end, {}),
        i(1), -- Position the cursor after the number
      })
    end, {}),
  }),

  s(
    { trig = "mm", wordTrig = false, regTrig = true },
    fmta("$ <> $", {
      d(1, get_visual),
    })
  ),

  s(
    { trig = "ee", dscr = "Euler's number" },
    fmta("e^{<>}", {
      d(1, get_visual),
    })
  ),

  s(
    { trig = "fit", dscr = "Expands 'fit' into LaTeX's textit{} command." },
    fmta("\\textit{<>}", {
      d(1, get_visual),
    })
  ),
}
