local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node

-- Add snippets to Lua filetype
ls.add_snippets('lua', {
  -- NOTE: These are just examples
  -- -- Simple print snippet
  -- s('p', {
  --   t 'print(',
  --   i(1, 'value'),
  --   t ')',
  -- }),
  --
  -- -- Local variable
  -- s('', {
  --   t 'local ',
  --   i(1, 'name'),
  --   t ' = ',
  --   i(2, 'value'),
  -- }),
  --
  -- -- Function definition
  -- s('fn', {
  --   t 'local function ',
  --   i(1, 'name'),
  --   t '(',
  --   i(2, 'args'),
  --   t ')',
  --   t { '', '  ' },
  --   i(0),
  --   t { '', 'end' },
  -- }),
  --
  -- -- Require statement
  -- s('req', {
  --   t 'local ',
  --   i(1, 'module'),
  --   t ' = require("',
  --   f(function(args) return args[1][1] end, { 1 }),
  --   t '")',
  -- }),
  --
  -- -- If statement
  -- s('if', {
  --   t 'if ',
  --   i(1, 'condition'),
  --   t ' then',
  --   t { '', '  ' },
  --   i(0),
  --   t { '', 'end' },
  -- }),
  --
  -- -- Keymap snippet
  -- s('keymap', {
  --   t "vim.keymap.set('",
  --   c(1, {
  --     t 'n',
  --     t 'i',
  --     t 'v',
  --     t 'x',
  --   }),
  --   t "', '",
  --   i(2, '<leader>'),
  --   t "', ",
  --   i(3, 'function()'),
  --   t ", { desc = '",
  --   i(4, 'description'),
  --   t "' })",
  -- }),
})
