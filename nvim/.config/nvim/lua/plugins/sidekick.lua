return {
  'folke/sidekick.nvim',
  opts = {
    nes = {
      enabled = true,
    },
    cli = {
      watch = true,
      mux = {
        enabled = true,
      },
      tools = {
        agy = {
          cmd = { 'agy' },
          is_proc = '\\<agy\\>',
        },
      },
    },
  },
  keys = {
    -- Next Edit Suggestions (NES)
    {
      '<tab>',
      function()
        if not require('sidekick').nes_jump_or_apply() then
          return '<Tab>'
        end
      end,
      expr = true,
      desc = 'Goto/Apply Next Edit Suggestion',
    },
    {
      '<leader>an',
      function() require('sidekick').nes_jump_or_apply() end,
      desc = 'NES: Jump / Apply Next Edit',
    },
    {
      '<leader>ae',
      function() require('sidekick.nes').toggle() end,
      desc = 'NES: Toggle Edit Suggestions',
    },

    -- AI Terminal & CLI Focus
    {
      '<c-.>',
      function() require('sidekick.cli').focus() end,
      desc = 'Sidekick: Focus Terminal',
      mode = { 'n', 't', 'i', 'x' },
    },
    {
      '<leader>a.',
      function() require('sidekick.cli').focus() end,
      desc = 'Sidekick: Focus Terminal',
      mode = { 'n', 't', 'x' },
    },
    {
      '<leader>aa',
      function() require('sidekick.cli').toggle() end,
      desc = 'Toggle AI Assistant',
    },
    {
      '<leader>as',
      function() require('sidekick.cli').select() end,
      desc = 'Select AI Tool',
    },
    {
      '<leader>ad',
      function() require('sidekick.cli').close() end,
      desc = 'Detach / Close AI Session',
    },

    -- Sending Context to AI
    {
      '<leader>ap',
      function() require('sidekick.cli').prompt() end,
      mode = { 'n', 'x' },
      desc = 'AI Prompt Menu (Explain/Fix/Test)',
    },
    {
      '<leader>ac',
      function() require('sidekick.cli').send { msg = '{this}' } end,
      mode = { 'n', 'x' },
      desc = 'Send Context under Cursor',
    },
    {
      '<leader>af',
      function() require('sidekick.cli').send { msg = '{file}' } end,
      desc = 'Send Current File',
    },
    {
      '<leader>av',
      function() require('sidekick.cli').send { msg = '{selection}' } end,
      mode = { 'x' },
      desc = 'Send Visual Selection',
    },
  },
}
