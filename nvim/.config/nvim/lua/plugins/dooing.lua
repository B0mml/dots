return {
  'atiladefreitas/dooing',
  cmd = { 'Dooing' },
  keys = {
    {
      '<leader>td',
      function() require('dooing').toggle() end,
      desc = 'Toggle Global Todos',
    },
    {
      '<leader>tD',
      function() require('dooing').toggle_project() end,
      desc = 'Toggle Project Todos',
    },
  },
  opts = {
    ui = {
      style = 'modern',
    },
  },
}
