return {

  'mrjones2014/smart-splits.nvim',
  lazy = false,
  config = function()
    require('smart-splits').setup {}

    -- movement
    vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
    vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
    vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
    vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)

    -- resizing
    vim.keymap.set('n', '<S-Left>', require('smart-splits').resize_left)
    vim.keymap.set('n', '<S-Down>', require('smart-splits').resize_down)
    vim.keymap.set('n', '<S-Up>', require('smart-splits').resize_up)
    vim.keymap.set('n', '<S-Right>', require('smart-splits').resize_right)
  end,
}
