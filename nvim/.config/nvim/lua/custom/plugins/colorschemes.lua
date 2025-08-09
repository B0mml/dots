return {
  {
    'rebelot/kanagawa.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    'thesimonho/kanagawa-paper.nvim',
    lazy = false,
    priority = 1000,
    -- init = function()
    --   vim.cmd.colorscheme 'kanagawa-paper-ink'
    -- end,
    opts = {},
  },
  {
    'navarasu/onedark.nvim',
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('onedark').setup {
        style = 'darker',
      }
      -- Enable theme
      -- require('onedark').load()
    end,
  },
  {
    'webhooked/kanso.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'EdenEast/nightfox.nvim',
  },
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
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      -- require('catppuccin').setup {
      --   transparent_background = true,
      -- }
    end,
  },
}
