-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- using lazy.nvim
  {
    'S1M0N38/love2d.nvim',
    event = 'VeryLazy',
    version = '2.*',
    opts = {
      debug_window_opts = {
        split = 'right',
      },
    },
    keys = {
      { '<leader>v', ft = 'lua', desc = 'LÖVE' },
      { '<leader>vv', '<cmd>LoveRun<cr>', ft = 'lua', desc = 'Run LÖVE' },
      { '<leader>vs', '<cmd>LoveStop<cr>', ft = 'lua', desc = 'Stop LÖVE' },
    },
  },

  {
    'mbbill/undotree',
    lazy = false,

    vim.keymap.set('n', '<leader>uu', vim.cmd.UndotreeToggle, { noremap = true, silent = true, desc = 'Toggle undotree' }),
  },

  {
    'github/copilot.vim',
    config = function()
      vim.g.copilot_enabled = 0
      -- Optional: Configure Copilot settings here
    end,
  },

  {
    'olimorris/codecompanion.nvim',
    opts = {},
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('codecompanion').setup {
        strategies = {
          chat = { adapter = 'copilot' },
          inline = { adapter = 'copilot' },
        },
        -- No model specification - use Copilot's default
      }

      vim.keymap.set('n', '<leader>ac', '<cmd>CodeCompanionChat<cr>', { desc = 'CodeCompanion Chat' })
      vim.keymap.set('n', '<leader>ai', '<cmd>CodeCompanion<cr>', { desc = 'CodeCompanion Inline' })
      vim.keymap.set('n', '<leader>aa', '<cmd>CodeCompanionActions<cr>', { desc = 'CodeCompanion Actions' })
    end,
  },
  {
    'shortcuts/no-neck-pain.nvim',
    config = function()
      require('no-neck-pain').setup {
        -- Your configuration options here
      }

      -- Simple toggle function with feedback
      local function toggle_no_neck_pain()
        vim.cmd 'NoNeckPain'
        -- The plugin doesn't expose state easily, so we'll use a simple message
        print 'No Neck Pain toggled'
      end

      -- Map to <leader>un
      vim.keymap.set('n', '<leader>un', toggle_no_neck_pain, {
        desc = 'Toggle No Neck Pain',
      })
    end,
  },
}
