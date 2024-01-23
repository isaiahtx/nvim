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

local function math()
  return vim.api.nvim_eval("vimtex#syntax#in_mathzone()") == 1
end

return {
  s(
    { trig = ";a", wordTrig = false, snippetType = "autosnippet" },
    { t("\\alpha") },
    { condition = math }
  ),
  s(
    { trig = ";b", snippetType = "autosnippet", wordTrig = false },
    { t("\\beta") },
    { condition = math }
  ),
  s(
    { trig = ";g", snippetType = "autosnippet", wordTrig = false },
    { t("\\gamma") },
    { condition = math }
  ),
  s(
    { trig = ";G", snippetType = "autosnippet", wordTrig = false },
    { t("\\Gamma") },
    { condition = math }
  ),
  s(
    { trig = ";d", snippetType = "autosnippet", wordTrig = false },
    { t("\\delta") },
    { condition = math }
  ),
  s(
    { trig = ";D", snippetType = "autosnippet", wordTrig = false },
    { t("\\Delta") },
    { condition = math }
  ),
  s(
    { trig = ";e", snippetType = "autosnippet", wordTrig = false },
    { t("\\epsilon") },
    { condition = math }
  ),
  s(
    { trig = ";ve", snippetType = "autosnippet", wordTrig = false },
    { t("\\varepsilon") },
    { condition = math }
  ),
  s(
    { trig = ";z", snippetType = "autosnippet", wordTrig = false },
    { t("\\zeta") },
    { condition = math }
  ),
  s(
    { trig = ";h", snippetType = "autosnippet", wordTrig = false },
    { t("\\eta") },
    { condition = math }
  ),
  s(
    { trig = ";th", snippetType = "autosnippet", wordTrig = false },
    { t("\\theta") },
    { condition = math }
  ),
  s(
    { trig = ";o", snippetType = "autosnippet", wordTrig = false },
    { t("\\theta") },
    { condition = math }
  ),
  s(
    { trig = ";vo", snippetType = "autosnippet", wordTrig = false },
    { t("\\vartheta") },
    { condition = math }
  ),
  s(
    { trig = ";O", snippetType = "autosnippet", wordTrig = false },
    { t("\\Theta") },
    { condition = math }
  ),
  s(
    { trig = ";k", snippetType = "autosnippet", wordTrig = false },
    { t("\\kappa") },
    { condition = math }
  ),
  s(
    { trig = ";l", snippetType = "autosnippet", wordTrig = false },
    { t("\\lambda") },
    { condition = math }
  ),
  s(
    { trig = ";L", snippetType = "autosnippet", wordTrig = false },
    { t("\\Lambda") },
    { condition = math }
  ),
  s(
    { trig = ";m", snippetType = "autosnippet", wordTrig = false },
    { t("\\mu") },
    { condition = math }
  ),
  s(
    { trig = ";n", snippetType = "autosnippet", wordTrig = false },
    { t("\\nu") },
    { condition = math }
  ),
  s(
    { trig = ";x", snippetType = "autosnippet", wordTrig = false },
    { t("\\xi") },
    { condition = math }
  ),
  s(
    { trig = ";X", snippetType = "autosnippet", wordTrig = false },
    { t("\\Xi") },
    { condition = math }
  ),
  s(
    { trig = ";p", snippetType = "autosnippet", wordTrig = false },
    { t("\\pi") },
    { condition = math }
  ),
  s(
    { trig = ";P", snippetType = "autosnippet", wordTrig = false },
    { t("\\Pi") },
    { condition = math }
  ),
  s(
    { trig = ";r", snippetType = "autosnippet", wordTrig = false },
    { t("\\rho") },
    { condition = math }
  ),
  s(
    { trig = ";R", snippetType = "autosnippet", wordTrig = false },
    { t("\\Rho") },
    { condition = math }
  ),
  s(
    { trig = ";s", snippetType = "autosnippet", wordTrig = false },
    { t("\\sigma") },
    { condition = math }
  ),
  s(
    { trig = ";S", snippetType = "autosnippet", wordTrig = false },
    { t("\\Sigma") },
    { condition = math }
  ),
  s(
    { trig = ";t", snippetType = "autosnippet", wordTrig = false },
    { t("\\tau") },
    { condition = math }
  ),
  s(
    { trig = ";y", snippetType = "autosnippet", wordTrig = false },
    { t("\\upsilon") },
    { condition = math }
  ),
  s(
    { trig = ";f", snippetType = "autosnippet", wordTrig = false },
    { t("\\phi") },
    { condition = math }
  ),
  s(
    { trig = ";F", snippetType = "autosnippet", wordTrig = false },
    { t("\\Phi") },
    { condition = math }
  ),
  s(
    { trig = ";vf", snippetType = "autosnippet", wordTrig = false },
    { t("\\varphi") },
    { condition = math }
  ),
  s(
    { trig = ";c", snippetType = "autosnippet", wordTrig = false },
    { t("\\chi") },
    { condition = math }
  ),
  s(
    { trig = ";u", snippetType = "autosnippet", wordTrig = false },
    { t("\\psi") },
    { condition = math }
  ),
  s(
    { trig = ";U", snippetType = "autosnippet", wordTrig = false },
    { t("\\Psi") },
    { condition = math }
  ),
  s(
    { trig = ";w", snippetType = "autosnippet", wordTrig = false },
    { t("\\omega") },
    { condition = math }
  ),
  s(
    { trig = ";W", snippetType = "autosnippet", wordTrig = false },
    { t("\\Omega") },
    { condition = math }
  ),
}
