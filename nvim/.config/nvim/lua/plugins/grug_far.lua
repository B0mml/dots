return {
  'MagicDuck/grug-far.nvim',
  cmd = { 'GrugFar', 'GrugFarWithin' },
  keys = {
    {
      '<leader>sr',
      function() require('grug-far').open() end,
      desc = 'Search and Replace (GrugFar)',
    },
    {
      '<leader>sr',
      function() require('grug-far').with_visual_selection() end,
      mode = 'v',
      desc = 'Search and Replace selection (GrugFar)',
    },
    {
      '<leader>sw',
      function() require('grug-far').open { prefills = { search = vim.fn.expand '<cword>' } } end,
      desc = 'Search current word (GrugFar)',
    },
  },
  opts = {},
}
