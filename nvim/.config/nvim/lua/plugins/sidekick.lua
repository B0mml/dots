return {
  'folke/sidekick.nvim',
  event = 'VeryLazy',
  opts = {
    nes = { enabled = true },
    cli = {
      mux = {
        enabled = true,
      },
    },
  },
  keys = {
    {
      '<tab>',
      function()
        if not require('sidekick').nes_jump_or_apply() then
          return '<tab>'
        end
      end,
      expr = true,
      mode = { 'i', 'n' },
      desc = 'Sidekick: Jump or Apply Edit Suggestion',
    },
    { '<leader>aa', function() require('sidekick.cli').toggle() end, desc = 'Toggle AI Sidekick CLI' },
    { '<leader>as', function() require('sidekick.cli').select() end, desc = 'Select AI CLI Tool' },
    { '<leader>ap', function() require('sidekick.cli').prompt() end, desc = 'Sidekick Prompt' },
    { '<leader>an', function() require('sidekick').nes_jump_or_apply() end, desc = 'Jump / Apply Edit Suggestion' },
    { '<leader>at', function() require('sidekick.nes').toggle() end, desc = 'Toggle Edit Suggestions (NES)' },
  },
}
