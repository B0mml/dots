return {
  {
    'AlexvZyl/nordic.nvim',
    priority = 1000,
    config = function()
      require('nordic').setup {
        on_palette = function(palette) palette.gray0 = '#1b1f28' end,
        after_palette = function(palette)
          local U = require 'nordic.utils'
          palette.bg_visual = U.blend(palette.orange.dim, palette.bg, 0.15)
        end,
      }
    end,
  },
  {
    'serhez/teide.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
  },
}
