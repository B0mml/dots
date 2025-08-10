return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    dashboard = {
      enabled = true,
      width = 18,
      sections = {
        -- stylua: ignore start
        { hidden = true, icon = " ", key = "t", desc = "Find [T]ext", action = ":lua Snacks.dashboard.pick('live_grep')" },
        { hidden = true, icon = " ", key = "r", desc = "[R]ecent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
        { hidden = true, icon = "󰒲 ", key = "l", desc = "[L]azy", action = ":Lazy" },
        -- stylua: ignore end

        -- Header
        { text = ' ', padding = 12 },
        {
          padding = 2,
          text = {
            { 'Neovim :: M Λ C R O ', hl = 'Normal' },
            { '- Editing made simple', hl = 'NonText' },
          },
          action = ":lua Snacks.dashboard.pick('files')",
          key = 'f',
        },

        -- Keys
        {
          padding = 1,
          text = {
            { '  Find [F]ile', width = 19, hl = 'NonText' },
            { '  Find [T]ext', hl = 'NonText' },
          },
          action = ":lua Snacks.dashboard.pick('files')",
          key = 'f',
        },
        {
          padding = 1,
          text = {
            { ' ', width = 3 },
            { '  [N]ew File', width = 19, hl = 'NonText' },
            { '  [R]ecent File', hl = 'NonText' },
          },
          action = ':ene | startinsert',
          key = 'n',
        },
        {
          padding = 2,
          text = {
            { ' ', width = 9 },
            { '  [C]onfig', hl = 'NonText' },
            { ' ', width = 8 },
            { '󰒲  [L]azy', hl = 'NonText' },
            { ' ', width = 14 },
          },
          action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          key = 'c',
        },
        {
          padding = 2,
          text = {
            { ' ', width = 5 },
            { '  [Q]uit', hl = 'NonText' },
          },
          action = ':quitall',
          key = 'q',
        },

        --  Startup
        { section = 'startup', padding = 1 },
        { section = 'terminal', cmd = "printf ' '", height = 15 },

        -- Keys
        {
          text = {
            [[
Copyright (c) 2025 - M Λ C R O developers
            ]],

            hl = 'NonText',
          },
        },
      },

      formats = { key = { '' } },
    },
  },
  --     dashboard = {
  --       enabled = true,
  --       width = 80,
  --       preset = {
  --         header = [[
  --                                             
  --      ████ ██████           █████      ██
  --     ███████████             █████ 
  --     █████████ ███████████████████ ███   ███████████
  --    █████████  ███    █████████████ █████ ██████████████
  --   █████████ ██████████ █████████ █████ █████ ████ █████
  -- ███████████ ███    ███ █████████ █████ █████ ████ █████
  -- ██████  █████████████████████ ████ █████ █████ ████ ██████]],
  --       },
  --       sections = {
  --         { section = 'header' },
  --         {
  --           pane = 2,
  --           section = 'terminal',
  --           cmd = "'curl -s 'wttr.in/?0'",
  --           height = 5,
  --           padding = 1,
  --         },
  --         { section = 'keys', gap = 1, padding = 1 },
  --         {
  --           pane = 2,
  --           icon = ' ',
  --           title = 'Recent Files',
  --           section = 'recent_files',
  --           indent = 2,
  --           padding = 1,
  --         },
  --         {
  --           pane = 2,
  --           icon = ' ',
  --           title = 'Projects',
  --           section = 'projects',
  --           indent = 2,
  --           padding = 1,
  --         },
  --         {
  --           pane = 2,
  --           icon = ' ',
  --           title = 'Git Status',
  --           section = 'terminal',
  --           enabled = function() return Snacks.git.get_root() ~= nil end,
  --           cmd = 'git status --short --branch --renames',
  --           height = 5,
  --           padding = 1,
  --           ttl = 5 * 60,
  --           indent = 3,
  --         },
  --         { section = 'startup' },
  --       },
  --     },
  --   },
  config = function(_, opts)
    require("snacks").setup(opts)
    
    local function hide_cursor_in_dashboard()
      local function cursor_blend(value)
        local hl = vim.api.nvim_get_hl(0, { name = "Cursor", create = true })
        hl.blend = value

        ---@diagnostic disable-next-line: param-type-mismatch
        vim.api.nvim_set_hl(0, "Cursor", hl)
        vim.cmd("set guicursor+=a:Cursor/lCursor")
      end

      -- required for initial dashboard, BufEnter is too late
      vim.api.nvim_create_autocmd("User", {
        pattern = "SnacksDashboardOpened",
        callback = function()
          cursor_blend(100)
          vim.opt_local.fillchars:append("eob: ")
        end,
        once = true,
      })

      -- required for re-opening the dashboard later
      vim.api.nvim_create_autocmd("BufEnter", {
        callback = function()
          if vim.bo.filetype == "snacks_dashboard" then
            cursor_blend(100)
          end
        end,
      })

      -- make cursor visible again when leaving the dashboard
      vim.api.nvim_create_autocmd("BufLeave", {
        callback = function()
          if vim.bo.filetype == "snacks_dashboard" then
            cursor_blend(0)
          end
        end,
      })
    end
    
    hide_cursor_in_dashboard()
  end,
}
