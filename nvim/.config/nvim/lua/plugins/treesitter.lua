return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    lazy = false,
    config = function()
      -- Enable built-in treesitter highlighting via autocmd
      vim.api.nvim_create_autocmd('FileType', {
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })

      -- Install parsers asynchronously using the new treesitter API
      local ensure_installed = {
        'bash',
        'c',
        'diff',
        'go',
        'gomod',
        'gosum',
        'html',
        'json',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'odin',
        'query',
        'rust',
        'toml',
        'vim',
        'vimdoc',
        'yaml',
      }

      local ok, ts_config = pcall(require, 'nvim-treesitter.config')
      if ok then
        local installed = ts_config.get_installed()
        local to_install = vim.tbl_filter(function(p) return not vim.tbl_contains(installed, p) end, ensure_installed)

        if #to_install > 0 then require('nvim-treesitter').install(to_install) end
      else
        require('nvim-treesitter').install(ensure_installed)
      end
    end,
  },

  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      local ok, textobjects = pcall(require, 'nvim-treesitter-textobjects')
      if not ok then return end

      textobjects.setup {
        select = {
          lookahead = true,
        },
        move = {
          set_jumps = true,
        },
      }

      local select = require 'nvim-treesitter-textobjects.select'
      local move = require 'nvim-treesitter-textobjects.move'
      local swap = require 'nvim-treesitter-textobjects.swap'

      -- Select textobjects (vaf, vif, vac, etc.)
      local select_maps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['ab'] = '@block.outer',
        ['ib'] = '@block.inner',
      }
      for key, query in pairs(select_maps) do
        vim.keymap.set({ 'x', 'o' }, key, function() select.select_textobject(query, 'textobjects') end, { desc = 'Select ' .. query })
      end

      -- Swap parameters
      vim.keymap.set('n', '<C-A-l>', function() swap.swap_next '@parameter.inner' end, { desc = 'Swap next parameter' })
      vim.keymap.set('n', '<C-A-h>', function() swap.swap_previous '@parameter.inner' end, { desc = 'Swap prev parameter' })

      -- Jump / Move mappings (]f, [f, ]c, [c, etc.)
      vim.keymap.set({ 'n', 'x', 'o' }, ']f', function() move.goto_next_start('@function.outer', 'textobjects') end, { desc = 'Next function start' })
      vim.keymap.set({ 'n', 'x', 'o' }, ']F', function() move.goto_next_end('@function.outer', 'textobjects') end, { desc = 'Next function end' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[f', function() move.goto_previous_start('@function.outer', 'textobjects') end, { desc = 'Prev function start' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[F', function() move.goto_previous_end('@function.outer', 'textobjects') end, { desc = 'Prev function end' })

      vim.keymap.set({ 'n', 'x', 'o' }, ']c', function() move.goto_next_start('@class.outer', 'textobjects') end, { desc = 'Next class start' })
      vim.keymap.set({ 'n', 'x', 'o' }, ']C', function() move.goto_next_end('@class.outer', 'textobjects') end, { desc = 'Next class end' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[c', function() move.goto_previous_start('@class.outer', 'textobjects') end, { desc = 'Prev class start' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[C', function() move.goto_previous_end('@class.outer', 'textobjects') end, { desc = 'Prev class end' })

      vim.keymap.set({ 'n', 'x', 'o' }, ']a', function() move.goto_next_start('@parameter.inner', 'textobjects') end, { desc = 'Next param' })
      vim.keymap.set({ 'n', 'x', 'o' }, ']A', function() move.goto_next_end('@parameter.inner', 'textobjects') end, { desc = 'Next param end' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[a', function() move.goto_previous_start('@parameter.inner', 'textobjects') end, { desc = 'Prev param' })
      vim.keymap.set({ 'n', 'x', 'o' }, '[A', function() move.goto_previous_end('@parameter.inner', 'textobjects') end, { desc = 'Prev param end' })
    end,
  },
}
