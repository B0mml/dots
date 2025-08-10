local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- Lua-specific snippets
ls.add_snippets('lua', {
  s('req', {
    t "local ",
    i(1),
    t " = require('",
    i(2),
    t "')",
  }),
})