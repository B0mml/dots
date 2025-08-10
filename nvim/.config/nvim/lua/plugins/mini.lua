-- Mini.nvim collection of plugins
return {
  {
    'echasnovski/mini.nvim',
    config = function()
      -- Mini AI
      require('mini.ai').setup { n_lines = 500 }

      -- Mini surround with custom mappings
      require('mini.surround').setup {
        mappings = {
          add = 'ma',
          delete = 'md',
          find = 'mf',
          replace = 'ms',
        },
      }

      -- Mini statusline
      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- Custom location format
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function() return '%2l:%-2v' end

      -- Mini files configuration
      require('mini.files').setup {
        windows = {
          preview = false,
          width_focus = 40,
          width_nofocus = 15,
          width_preview = 60,
        },
        mappings = {
          close = 'q',
          go_in = 'l',
          go_in_plus = 'L',
          go_out = 'h',
          go_out_plus = 'H',
          mark_goto = "'",
          mark_set = 'm',
          reset = '<BS>',
          reveal_cwd = '@',
          show_help = 'g?',
          synchronize = '=',
          trim_left = '<',
          trim_right = '>',
        },
      }

      -- File explorer toggle
      vim.keymap.set('n', '-', function()
        if not require('mini.files').close() then require('mini.files').open() end
      end, { desc = 'Open File Explorer' })

      -- Mini files enhancements
      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function(args)
          local buf_id = args.data.buf_id

          -- Enter key to open file and close mini.files
          vim.keymap.set(
            'n',
            '<CR>',
            function() require('mini.files').go_in { close_on_file = true } end,
            { buffer = buf_id, desc = 'Open file and close explorer' }
          )

          -- Toggle preview
          vim.keymap.set('n', 'P', function()
            local config = require('mini.files').config
            config.windows.preview = not config.windows.preview
            require('mini.files').refresh { windows = { preview = config.windows.preview } }
          end, { buffer = buf_id, desc = 'Toggle preview' })

          -- Cursor wrapping for j/k
          vim.keymap.set('n', 'j', function()
            local line = vim.api.nvim_win_get_cursor(0)[1]
            local total_lines = vim.api.nvim_buf_line_count(buf_id)
            if line >= total_lines then
              vim.api.nvim_win_set_cursor(0, { 1, 0 })
            else
              vim.cmd 'normal! j'
            end
          end, { buffer = buf_id, desc = 'Move down (with wrap)' })

          vim.keymap.set('n', 'k', function()
            local line = vim.api.nvim_win_get_cursor(0)[1]
            if line <= 1 then
              local total_lines = vim.api.nvim_buf_line_count(buf_id)
              vim.api.nvim_win_set_cursor(0, { total_lines, 0 })
            else
              vim.cmd 'normal! k'
            end
          end, { buffer = buf_id, desc = 'Move up (with wrap)' })
        end,
      })

      -- Mini sessions
      require('mini.sessions').setup {
        force = { delete = true },
      }

      -- Session management keymaps
      vim.keymap.set('n', '<leader>pS', function()
        local name = vim.fn.input 'New global project name: '
        if name ~= '' then MiniSessions.write(name) end
      end, { desc = 'Save new global session' })

      vim.keymap.set('n', '<leader>ps', function() MiniSessions.write 'Session.vim' end, { desc = 'Save local project' })

      vim.keymap.set('n', '<leader>pw', function()
        if vim.v.this_session == '' then
          local name = vim.fn.input 'Session name: '
          if name ~= '' then MiniSessions.write(name) end
        else
          MiniSessions.write()
        end
      end, { desc = 'Write/overwrite project' })

      vim.keymap.set('n', '<leader>pl', function() MiniSessions.read() end, { desc = 'Load project' })

      vim.keymap.set('n', '<leader>pd', function() MiniSessions.select 'delete' end, { desc = 'Delete project' })

      vim.keymap.set('n', '<leader>pp', function() MiniSessions.select() end, { desc = 'Pick project' })
    end,
  },
}
