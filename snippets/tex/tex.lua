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
      trig = "tff",
      wordTrig = false,
      snippetType = "autosnippet",
    },
    fmt("\\tfrac{<>}{<>}", { d(1, get_visual), i(2) }, { delimiters = "<>" }),
    { condition = math }
  ),

  s(
    {
      trig = "dff",
      wlrdTrig = false,
      snippetType = "autosnippet",
    },
    fmt("\\dfrac{<>}{<>}", { d(1, get_visual), i(2) }, { delimiters = "<>" }),
    { condition = math }
  ),

  s(
    {
      trig = "ff",
      wordTrig = false,
      snippetType = "autosnippet",
    },
    fmt("\\frac{<>}{<>}", { d(1, get_visual), i(2) }, { delimiters = "<>" }),
    {
      condition = function(line_to_cursor)
        -- Check if the characters preceding 'ff' are not '\i'
        return (vim.api.nvim_eval("vimtex#syntax#in_mathzone()") == 1)
          and (not string.match(line_to_cursor, "\\iff$"))
      end,
      show_condition = math,
    }
  ),

  s(
    { trig = "cal", wordTrig = false },
    fmta("\\mathcal{<>}", {
      d(1, get_visual),
    }),
    { condition = math }
  ),

  s(
    { trig = "mf", wordTrig = false },
    fmta("\\mathfrak{<>}", {
      d(1, get_visual),
    }),
    { condition = math }
  ),

  s(
    { trig = "scr", wordTrig = false },
    fmta("\\mathscr{<>}", {
      d(1, get_visual),
    }),
    { condition = math }
  ),

  s(
    { trig = "wh", wordTrig = false },
    fmta("\\widehat{<>}", {
      d(1, get_visual),
    }),
    { condition = math }
  ),

  s(
    { trig = "bs", wordTrig = false },
    fmta("\\boldsymbol{<>}", {
      d(1, get_visual),
    }),
    { condition = math }
  ),

  s(
    { trig = "wt", wordTrig = false },
    fmta("\\widetilde{<>}", {
      d(1, get_visual),
    }),
    { condition = math }
  ),

  s(
    { trig = "ov", wordTrig = false },
    fmta("\\overset{<>}", {
      d(1, get_visual),
    }),
    { condition = math }
  ),

  s(
    { trig = "ul", wordTrig = false },
    fmta("\\underline{<>}", {
      d(1, get_visual),
    }),
    { condition = math }
  ),

  s(
    { trig = "ol", wordTrig = false },
    fmta("\\overline{<>}", {
      d(1, get_visual),
    }),
    { condition = math }
  ),

  s(
    { trig = "rm", wordTrig = false },
    fmta("\\mathrm{<>}", {
      d(1, get_visual),
    }),
    { condition = math }
  ),

  s(
    { trig = "bf", wordTrig = false },
    fmta("\\mathbf{<>}", {
      d(1, get_visual),
    }),
    { condition = math }
  ),

  s(
    { trig = "bb", wordTrig = false },
    fmta("\\mathbb{<>}", {
      d(1, get_visual),
    }),
    { condition = math }
  ),

  s(
    { trig = "al" },
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
    { trig = "eq" },
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
    { trig = "enum" },
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
    { trig = "env" },
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
    { trig = "prod", wordTrig = false, snippetType = "autosnippet" },
    fmta("\\prod_{<>}^{<>}", {
      i(1),
      i(2),
    }),
    { condition = math }
  ),

  s(
    { trig = "toinf", wordTrig = false, snippetType = "autosnippet" },
    fmta("\\to\\infty", {}),
    { condition = math }
  ),

  s({ trig = "iff" }, fmta("if and only if", {}), { condition = not math }),

  s(
    { trig = "inf", wordTrig = false },
    fmta("\\infty", {}),
    { condition = math }
  ),

  s(
    { trig = "int", wordTrig = false },
    fmta("\\int_{<>}^{<>}", {
      i(1),
      i(2),
    }),
    { condition = math }
  ),

  s(
    { trig = "sum", wordTrig = false, snippetType = "autosnippet" },
    fmta("\\sum_{<>}^{<>}", {
      i(1),
      i(2),
    }),
    { condition = math }
  ),

  s(
    { trig = "hr" },
    fmta("\\href{<>}{<>}", {
      i(1, "url"),
      i(2, "display name"),
    })
  ),

  s(
    { trig = "MM", snippetType = "autosnippet" },
    fmta(
      [[
        \[
          <>
        \]
      ]],
      {
        d(1, get_visual),
      }
    )
  ),

  s(
    { trig = "mm", snippetType = "autosnippet" },
    fmta("$<>$", {
      d(1, get_visual),
    })
  ),

  s(
    { trig = "limsup" },
    fmta("\\limsup_{<>}", {
      i(1, "n\\to\\infty"),
    }),
    { condition = math }
  ),

  s(
    { trig = "liminf" },
    fmta("\\liminf_{<>}", {
      i(1, "n\\to\\infty"),
    }),
    { condition = math }
  ),

  s(
    { trig = "lim" },
    fmta("\\lim_{<>}", {
      i(1, "n\\to\\infty"),
    }),
    { condition = math }
  ),

  s(
    { trig = "sseq", wordTrig = false, snippetType = "autosnippet" },
    { t("\\subseteq") },
    { condition = math }
  ),

  s(
    { trig = "onto", wordTrig = false, snippetType = "autosnippet" },
    { t("\\twoheadrightarrow") },
    { condition = math }
  ),

  s(
    { trig = "into", wordTrig = false, snippetType = "autosnippet" },
    { t("\\hookrightarrow") },
    { condition = math }
  ),

  s(
    { trig = "spseq", wordTrig = false, snippetType = "autosnippet" },
    { t("\\supseteq") },
    { condition = math }
  ),

  s(
    { trig = "xr" },
    fmta("\\xrightarrow{<>}", {
      d(1, get_visual),
    }),
    { condition = math }
  ),

  s(
    { trig = "ee", wordTrig = false, snippetType = "autosnippet" },
    fmta("e^{<>}", {
      d(1, get_visual),
    }),
    { condition = math }
  ),

  s(
    { trig = "emph" },
    fmta("\\emph{<>}", {
      d(1, get_visual),
    })
  ),

  s(
    { trig = "fit" },
    fmta("\\textit{<>}", {
      d(1, get_visual),
    })
  ),

  s(
    { trig = "fbf" },
    fmta("\\textbf{<>}", {
      d(1, get_visual),
    })
  ),

  s(
    { trig = "dlb", wordTrig = false, snippetType = "autosnippet" },
    fmta("\\left[<>\\right]", { d(1, get_visual) }),
    { condition = math }
  ),

  s(
    { trig = "dllan", wordTrig = false, snippetType = "autosnippet" },
    fmta("\\left\\langle<>\\right\\rangle", { d(1, get_visual) }),
    { condition = math }
  ),

  s(
    { trig = "dlda", wordTrig = false, snippetType = "autosnippet" },
    fmta("\\left\\|<>\\right\\|", { d(1, get_visual) }),
    { condition = math }
  ),

  s(
    { trig = "dla", wordTrig = false, snippetType = "autosnippet" },
    fmta("\\left|<>\\right|", { d(1, get_visual) }),
    { condition = math }
  ),

  s(
    { trig = "dlc", wordTrig = false, snippetType = "autosnippet" },
    fmta("\\left\\{<>\\right\\}", { d(1, get_visual) }),
    { condition = math }
  ),

  s(
    { trig = "dlcl", wordTrig = false, snippetType = "autosnippet" },
    fmta("\\left\\lceil<>\right\\rceil", { d(1, get_visual) }),
    { condition = math }
  ),

  s(
    { trig = "ceil", wordTrig = false, snippetType = "autosnippet" },
    fmta("\\lceil<>\\rceil", { d(1, get_visual) }),
    { condition = math }
  ),

  s(
    { trig = "floor", wordTrig = false, snippetType = "autosnippet" },
    fmta("\\lfloor<>\\rfloor", { d(1, get_visual) }),
    { condition = math }
  ),

  s(
    { trig = "dlflr", wordTrig = false, snippetType = "autosnippet" },
    fmta("\\left\\lfloor<>\\right\\rfloor", { d(1, get_visual) }),
    { condition = math }
  ),

  s(
    { trig = "dlp", wordTrig = false, snippetType = "autosnippet" },
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

  s(
    {
      trig = "cal(%a)",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
    },
    fmt([[\mathcal{<>}]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }, { delimiters = "<>" }),
    { condition = math }
  ),

  s(
    {
      trig = "ol(%a)",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
    },
    fmt([[\overline{<>}]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }, { delimiters = "<>" }),
    {
      condition = function(line_to_cursor)
        -- Check if the character preceding 'ol' is not 'b', as in ``bold''
        return (vim.api.nvim_eval("vimtex#syntax#in_mathzone()") == 1)
          and (not string.match(string.sub(line_to_cursor, 1, -2), "bol$"))
      end,
      show_condition = math,
    }
  ),

  s(
    {
      trig = "scr(%a)",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
    },
    fmt([[\mathscr{<>}]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }, { delimiters = "<>" }),
    { condition = math }
  ),

  s(
    {
      trig = "bs(%a)",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
    },
    fmt([[\boldsymbol{<>}]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }, { delimiters = "<>" }),
    { condition = math }
  ),

  s(
    {
      trig = "wt(%a)",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
    },
    fmt([[\widetilde{<>}]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }, { delimiters = "<>" }),
    { condition = math }
  ),

  s(
    {
      trig = "wh(%a)",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
    },
    fmt([[\widehat{<>}]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }, { delimiters = "<>" }),
    { condition = math }
  ),

  s(
    {
      trig = "mf(%a)",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
    },
    fmt([[\mathfrak{<>}]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }, { delimiters = "<>" }),
    { condition = math }
  ),

  s(
    {
      trig = "bf(%a)",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
    },
    fmt([[\mathbf{<>}]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
    }, { delimiters = "<>" }),
    { condition = math }
  ),

  s(
    {
      trig = "sqrt(.)",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
    },
    fmt([[\sqrt{<><>}]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
    }, { delimiters = "<>" }),
    { condition = math }
  ),

  s(
    {
      trig = "bb(%a)",
      regTrig = true,
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

  s(
    {
      trig = "(%a)(%d)",
      regTrig = true,
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

  s(
    { trig = "qandq", snippetType = "autosnippet" },
    { t("\\qquad\\text{and}\\qquad") },
    { condition = math }
  ),
}
