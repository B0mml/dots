-- Core keymaps and key mappings
local M = {}

function M.setup()
  local keymap = vim.keymap.set

  -- Clear highlights on search when pressing <Esc> in normal mode
  keymap('n', '<Esc>', '<cmd>nohlsearch<CR>')

  -- Quick navigation
  keymap('n', ']q', ':cnext<CR>')
  keymap('n', '[q', ':cprev<CR>')

  -- Diagnostic keymaps
  keymap('n', '<leader>qo', function()
    vim.diagnostic.setloclist()
    vim.cmd 'lopen'
  end, { desc = 'Diagnostics to location list' })

  keymap('n', '<leader>qd', function()
    vim.diagnostic.setqflist()
    vim.cmd 'copen'
  end, { desc = 'Diagnostics to quickfix' })

  -- Exit terminal mode in the builtin terminal with a shortcut
  keymap('t', '<C-e><C-e>', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })
  keymap('t', '<Esc><Esc>', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })

  -- Window navigation - Use CTRL+<hjkl> to switch between windows
  keymap('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
  keymap('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
  keymap('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
  keymap('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
end

return M
