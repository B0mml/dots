return {
  {
    'S1M0N38/love2d.nvim',
    event = 'VeryLazy',
    version = '2.*',
    opts = {},
    keys = {
      { '<leader>v', ft = 'lua', desc = 'LÖVE' },
      { '<leader>vv', '<cmd>LoveRun<cr>', ft = 'lua', desc = 'Run LÖVE' },
      {
        '<leader>vc',
        function()
          require('love2d').setup { debug_window_opts = { split = 'right' } }
          vim.cmd 'LoveRun'
        end,
        ft = 'lua',
        desc = 'Run LÖVE with console',
      },
      { '<leader>vs', '<cmd>LoveStop<cr>', ft = 'lua', desc = 'Stop LÖVE' },
    },
  },
}
