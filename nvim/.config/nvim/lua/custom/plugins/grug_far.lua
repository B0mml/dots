return {
  'MagicDuck/grug-far.nvim',
  config = function()
    require('grug-far').setup {}

    vim.keymap.set('v', '<leader>ff', function() require('grug-far').open() end, { desc = 'GrugFar: Search and Replace' })
    vim.keymap.set('v', '<leader>ff', function() require('grug-far').open() end, { desc = 'GrugFar: Search and Replace' })

    vim.keymap.set('v', '<leader>ff', '<cmd>GrugFar<CR>', { desc = 'GrugFar: Search and Replace' })
    vim.keymap.set('v', '<leader>fw', '<cmd>GrugFarWithin<CR>', { desc = 'GrugFar: Search and Replace within' })
  end,
}
