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

local function math()
  return vim.api.nvim_eval("vimtex#syntax#in_mathzone()") == 1
end

local function env(name)
  local is_inside = vim.fn["vimtex#env#is_inside"](name)
  return (is_inside[1] > 0 and is_inside[2] > 0)
end

local mat = function(args, snip)
  local rows = tonumber(snip.captures[2])
  local cols = tonumber(snip.captures[3])
  local nodes = {}
  local ins_indx = 1
  for j = 1, rows do
    table.insert(nodes, r(ins_indx, tostring(j) .. "x1", i(1)))
    ins_indx = ins_indx + 1
    for k = 2, cols do
      table.insert(nodes, t(" & "))
      table.insert(nodes, r(ins_indx, tostring(j) .. "x" .. tostring(k), i(1)))
      ins_indx = ins_indx + 1
    end
    table.insert(nodes, t({ "\\\\", "" }))
  end
  return sn(nil, nodes)
end

return {
  s(
    {
      trig = "([bBpvV])mat(%d+)x(%d+)([ar])",
      regTrig = true,
      name = "matrix",
      dscr = "matrix trigger lets go",
    },
    fmt(
      [[
        \begin{<>}<>
        <>
        \end{<>}
      ]],
      {
        f(function(_, snip)
          return snip.captures[1] .. "matrix"
        end),
        f(function(_, snip) -- augments
          if snip.captures[4] == "a" then
            out = string.rep("c", tonumber(snip.captures[3]) - 1)
            return "[" .. out .. "|c]"
          end
          return ""
        end),
        d(1, mat),
        f(function(_, snip)
          return snip.captures[1] .. "matrix"
        end),
      },
      { delimiters = "<>" }
    )
  ),

  s(
    {
      trig = "ff",
      wordTrig = false,
      snippetType = "autosnippet",
    },
    fmt("\\frac{<>}{<>}", { i(1), i(2) }, { delimiters = "<>" }),
    { condition = math }
  ),

  s(
    { trig = "bf", dscr = "Expands 'bf' into '\\mathbf{}'" },
    fmta("\\mathbf{<>}", {
      d(1, get_visual),
    }),
    { condition = math }
  ),

  s(
    { trig = "bb", dscr = "Expands 'bb' into '\\mathbb{}'" },
    fmta("\\mathbb{<>}", {
      d(1, get_visual),
    }),
    { condition = math }
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
    ),
    { condition = math }
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
    { trig = "enum", dscr = "Expands 'eq' into an equation environment" },
    fmta(
      [[
        \begin{enumerate}[listparindent=\parindent,parsep=5pt,label={<>}]
          \item <>
        \end{enumerate}
      ]],
      { i(1, "\\arabic*."), i(2) }
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
      trig = "prod",
    },
    fmta("\\prod_{<>}^{<>}", {
      i(1),
      i(2),
    }),
    { condition = math }
  ),

  s(
    { trig = "inf", wordTrig = false },
    fmta("\\infty", {}),
    { condition = math }
  ),

  s(
    {
      trig = "sum",
    },
    fmta("\\sum_{<>}^{<>}", {
      i(1),
      i(2),
    }),
    { condition = math }
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

  s(
    { trig = "MM", wordTrig = false, snippetType = "autosnippet" },
    fmta("\\[<>\\]", {
      d(1, get_visual),
    })
  ),

  s(
    { trig = "mm", wordTrig = false, snippetType = "autosnippet" },
    fmta("$<>$", {
      d(1, get_visual),
    })
  ),

  s(
    { trig = "ee", dscr = "Euler's number" },
    fmta("e^{<>}", {
      d(1, get_visual),
    }),
    { condition = math }
  ),

  s(
    { trig = "fit", dscr = "Expands 'fit' into LaTeX's '\\textit{}' command." },
    fmta("\\textit{<>}", {
      d(1, get_visual),
    })
  ),

  s(
    { trig = "fbf", dscr = "Expands 'fbf' into LaTeX's '\\textbf{}' command." },
    fmta("\\textbf{<>}", {
      d(1, get_visual),
    })
  ),

  s(
    { trig = "dlb", wordTrig = false },
    fmta("\\left[<>\\right]", { d(1, get_visual) }),
    { condition = math }
  ),

  s(
    { trig = "dlc", wordTrig = false },
    fmta("\\left{<>\\right}", { d(1, get_visual) }),
    { condition = math }
  ),

  s(
    { trig = "dlp", wordTrig = false },
    fmta("\\left(<>\\right)", { d(1, get_visual) }),
    { condition = math }
  ),

  s(
    { trig = "^", wordTrig = false },
    fmta("^{<>}", {
      d(1, get_visual),
    }),
    { condition = math }
  ),

  s(
    { trig = "__", wordTrig = false, snippetType = "autosnippet" },
    fmta("_{<>}", {
      d(1, get_visual),
    }),
    { condition = math }
  ),

  -- sub super scripts
  s(
    {
      trig = "bb(%a)",
      regTrig = true,
      name = "auto subscript",
      wordTrig = false,
      snippetType = "autosnippet",
    },
    fmt([[\mathbb{<>}]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }, { delimiters = "<>" }),
    { condition = math }
  ),

  -- sub super scripts
  s(
    {
      trig = "(%a)(%d)",
      regTrig = true,
      name = "auto subscript",
      dscr = "hi",
      wordTrig = false,
      snippetType = "autosnippet",
    },
    fmt([[<>_<>]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
    }, { delimiters = "<>" }),
    { condition = math }
  ),

  s(
    {
      trig = "(%a)_(%d%d)",
      regTrig = true,
      name = "auto subscript 2",
      dscr = "auto subscript for 2+ digits",
      wordTrig = false,
      snippetType = "autosnippet",
    },
    fmt([[<>_{<><>}]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
      i(1),
    }, { delimiters = "<>" }),
    { condition = math }
  ),
}
