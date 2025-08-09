return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    dashboard = {
      enabled = true,
      width = 80,
      preset = {
        header = [[                                                 
                                                                  
     ████ ██████           █████      ██                    
    ███████████             █████                            
    █████████ ███████████████████ ███   ███████████  
   █████████  ███    █████████████ █████ ██████████████  
  █████████ ██████████ █████████ █████ █████ ████ █████  
███████████ ███    ███ █████████ █████ █████ ████ █████ 
██████  █████████████████████ ████ █████ █████ ████ ██████]],
      },
      sections = {
        { section = 'header' },
        {
          pane = 2,
          section = 'terminal',
          cmd = 'astroterm --color --constellations --speed 10000 --fps 64 --city Singapore',
          height = 35,
        },
        { section = 'keys', gap = 1, padding = 1 },
        -- {
        --   pane = 2,
        --   icon = ' ',
        --   title = 'Recent Files',
        --   section = 'recent_files',
        --   indent = 2,
        --   padding = 1,
        -- },
        -- {
        --   pane = 2,
        --   icon = ' ',
        --   title = 'Projects',
        --   section = 'projects',
        --   indent = 2,
        --   padding = 1,
        -- },
        {
          pane = 1,
          icon = ' ',
          title = 'Git Status',
          section = 'terminal',
          enabled = function() return Snacks.git.get_root() ~= nil end,
          cmd = 'git status --short --branch --renames',
          height = 5,
          padding = 1,
          ttl = 5 * 60,
          indent = 3,
        },
        { section = 'startup' },
      },
    },
  },
}
