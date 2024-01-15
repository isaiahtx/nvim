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

return {
  s({ trig = ";a", snippetType = "autosnippet", wordTrig = false }, {
    t("\\alpha"),
  }),
  s({ trig = ";b", snippetType = "autosnippet", wordTrig = false }, {
    t("\\beta"),
  }),
  s({ trig = ";g", snippetType = "autosnippet", wordTrig = false }, {
    t("\\gamma"),
  }),
  s({ trig = ";G", snippetType = "autosnippet", wordTrig = false }, {
    t("\\Gamma"),
  }),
  s({ trig = ";d", snippetType = "autosnippet", wordTrig = false }, {
    t("\\delta"),
  }),
  s({ trig = ";D", snippetType = "autosnippet", wordTrig = false }, {
    t("\\Delta"),
  }),
  s({ trig = ";e", snippetType = "autosnippet", wordTrig = false }, {
    t("\\epsilon"),
  }),
  s({ trig = ";ve", snippetType = "autosnippet", wordTrig = false }, {
    t("\\varepsilon"),
  }),
  s({ trig = ";z", snippetType = "autosnippet", wordTrig = false }, {
    t("\\zeta"),
  }),
  s({ trig = ";h", snippetType = "autosnippet", wordTrig = false }, {
    t("\\eta"),
  }),
  s({ trig = ";th", snippetType = "autosnippet", wordTrig = false }, {
    t("\\theta"),
  }),
  s({ trig = ";o", snippetType = "autosnippet", wordTrig = false }, {
    t("\\theta"),
  }),
  s({ trig = ";vo", snippetType = "autosnippet", wordTrig = false }, {
    t("\\vartheta"),
  }),
  s({ trig = ";O", snippetType = "autosnippet", wordTrig = false }, {
    t("\\Theta"),
  }),
  s({ trig = ";k", snippetType = "autosnippet", wordTrig = false }, {
    t("\\kappa"),
  }),
  s({ trig = ";l", snippetType = "autosnippet", wordTrig = false }, {
    t("\\lambda"),
  }),
  s({ trig = ";L", snippetType = "autosnippet", wordTrig = false }, {
    t("\\Lambda"),
  }),
  s({ trig = ";m", snippetType = "autosnippet", wordTrig = false }, {
    t("\\mu"),
  }),
  s({ trig = ";n", snippetType = "autosnippet", wordTrig = false }, {
    t("\\nu"),
  }),
  s({ trig = ";x", snippetType = "autosnippet", wordTrig = false }, {
    t("\\xi"),
  }),
  s({ trig = ";X", snippetType = "autosnippet", wordTrig = false }, {
    t("\\Xi"),
  }),
  s({ trig = ";p", snippetType = "autosnippet", wordTrig = false }, {
    t("\\pi"),
  }),
  s({ trig = ";P", snippetType = "autosnippet", wordTrig = false }, {
    t("\\Pi"),
  }),
  s({ trig = ";r", snippetType = "autosnippet", wordTrig = false }, {
    t("\\rho"),
  }),
  s({ trig = ";R", snippetType = "autosnippet", wordTrig = false }, {
    t("\\Rho"),
  }),
  s({ trig = ";s", snippetType = "autosnippet", wordTrig = false }, {
    t("\\sigma"),
  }),
  s({ trig = ";S", snippetType = "autosnippet", wordTrig = false }, {
    t("\\Sigma"),
  }),
  s({ trig = ";t", snippetType = "autosnippet", wordTrig = false }, {
    t("\\tau"),
  }),
  s({ trig = ";y", snippetType = "autosnippet", wordTrig = false }, {
    t("\\upsilon"),
  }),
  s({ trig = ";f", snippetType = "autosnippet", wordTrig = false }, {
    t("\\phi"),
  }),
  s({ trig = ";F", snippetType = "autosnippet", wordTrig = false }, {
    t("\\Phi"),
  }),
  s({ trig = ";vf", snippetType = "autosnippet", wordTrig = false }, {
    t("\\varphi"),
  }),
  s({ trig = ";c", snippetType = "autosnippet", wordTrig = false }, {
    t("\\chi"),
  }),
  s({ trig = ";u", snippetType = "autosnippet", wordTrig = false }, {
    t("\\psi"),
  }),
  s({ trig = ";U", snippetType = "autosnippet", wordTrig = false }, {
    t("\\Psi"),
  }),
  s({ trig = ";w", snippetType = "autosnippet", wordTrig = false }, {
    t("\\omega"),
  }),
  s({ trig = ";W", snippetType = "autosnippet", wordTrig = false }, {
    t("\\Omega"),
  }),
}
