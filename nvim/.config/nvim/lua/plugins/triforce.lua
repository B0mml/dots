return {
  {
    'gisketch/triforce.nvim',
    dependencies = { 'nvzone/volt' },
    cmd = { 'Triforce' },
    keys = {
      {
        '<leader>tp',
        function() require('triforce').show_profile() end,
        desc = 'Triforce: Show RPG Profile',
      },
    },
    opts = {
      icon_engine = 'mini',
      backdrop = {
        enabled = true,
        winblend = 20,
      },
    },
  },
}
