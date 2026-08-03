return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    lazy = false,
    config = function()
      -- Enable built-in treesitter highlighting & indentation via autocmd
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          pcall(vim.treesitter.start)

          if vim.bo[args.buf].filetype ~= 'ruby' then vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
        end,
      })

      -- Install missing parsers safely
      local ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
      }

      local ok, ts_config = pcall(require, 'nvim-treesitter.config')
      if ok then
        local installed = ts_config.get_installed()
        local to_install = vim.tbl_filter(function(p) return not vim.tbl_contains(installed, p) end, ensure_installed)

        if #to_install > 0 then require('nvim-treesitter').install(to_install) end
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
          enable = true,
          lookahead = true,
          keymaps = {
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['ab'] = '@block.outer',
            ['ib'] = '@block.inner',
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['<C-A-l>'] = '@parameter.inner',
          },
          swap_previous = {
            ['<C-A-h>'] = '@parameter.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            [']f'] = '@function.outer',
            [']c'] = '@class.outer',
            [']a'] = '@parameter.inner',
          },
          goto_next_end = {
            [']F'] = '@function.outer',
            [']C'] = '@class.outer',
            [']A'] = '@parameter.inner',
          },
          goto_previous_start = {
            ['[f'] = '@function.outer',
            ['[c'] = '@class.outer',
            ['[a'] = '@parameter.inner',
          },
          goto_previous_end = {
            ['[F'] = '@function.outer',
            ['[C'] = '@class.outer',
            ['[A'] = '@parameter.inner',
          },
        },
      }
    end,
  },
}
