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
        -- Custom header - replace this with your desired ASCII art or text
        --        header = [[
        --            :h-                                  Nhy`
        --           -mh.                           h.    `Ndho
        --           hmh+                          oNm.   oNdhh
        --          `Nmhd`                        /NNmd  /NNhhd
        --          -NNhhy                      `hMNmmm`+NNdhhh
        --          .NNmhhs              ```....`..-:/./mNdhhh+
        --           mNNdhhh-     `.-::///+++////++//:--.`-/sd`
        --           oNNNdhhdo..://++//++++++/+++//++///++/-.`
        --      y.   `mNNNmhhhdy+/++++//+/////++//+++///++////-` `/oos:
        -- .    Nmy:  :NNNNmhhhhdy+/++/+++///:.....--:////+++///:.`:s+
        -- h-   dNmNmy oNNNNNdhhhhy:/+/+++/-         ---:/+++//++//.`
        -- hd+` -NNNy`./dNNNNNhhhh+-://///    -+oo:`  ::-:+////++///:`
        -- /Nmhs+oss-:++/dNNNmhho:--::///    /mmmmmo  ../-///++///////.
        --  oNNdhhhhhhhs//osso/:---:::///    /yyyyso  ..o+-//////////:/.
        --   /mNNNmdhhhh/://+///::://////     -:::- ..+sy+:////////::/:/.
        --     /hNNNdhhs--:/+++////++/////.      ..-/yhhs-/////////::/::/`
        --       .ooo+/-::::/+///////++++//-/ossyyhhhhs/:///////:::/::::/:
        --       -///:::::::////++///+++/////:/+ooo+/::///////.::://::---+`
        --       /////+//++++/////+////-..//////////::-:::--`.:///:---:::/:
        --       //+++//++++++////+++///::--                 .::::-------::
        --       :/++++///////////++++//////.                -:/:----::../-
        --       -/++++//++///+//////////////               .::::---:::-.+`
        --       `////////////////////////////:.            --::-----...-/
        --        -///://////////////////////::::-..      :-:-:-..-::.`.+`
        --         :/://///:///::://::://::::::/:::::::-:---::-.-....``/- -
        --           ::::://::://::::::::::::::----------..-:....`.../- -+oo/
        --            -/:::-:::::---://:-::-::::----::---.-.......`-/.      ``
        --           s-`::--:::------:////----:---.-:::...-.....`./:
        --          yMNy.`::-.--::..-dmmhhhs-..-.-.......`.....-/:`
        --         oMNNNh. `-::--...:NNNdhhh/.--.`..``.......:/-
        --        :dy+:`      .-::-..NNNhhd+``..`...````.-::-`
        --                        .-:mNdhh:.......--::::-`
        --                           yNh/..------..`                          ]],
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
        -- {
        --   pane = 2,
        --   section = 'terminal',
        --   cmd = 'powershell.exe -NoProfile -ExecutionPolicy Bypass -File "C:\\Users\\ludei\\scripts\\colorblocks.ps1"',
        --   height = 5,
        --   padding = 1,
        -- },
        { section = 'keys', gap = 1, padding = 1 },
        {
          pane = 2,
          icon = ' ',
          title = 'Recent Files',
          section = 'recent_files',
          indent = 2,
          padding = 1,
        },
        {
          pane = 2,
          icon = ' ',
          title = 'Projects',
          section = 'projects',
          indent = 2,
          padding = 1,
        },
        {
          pane = 2,
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
