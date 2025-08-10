return {
  'obsidian-nvim/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = 'markdown',
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    -- Required.
    'nvim-lua/plenary.nvim',
    'snacks.nvim',
    'Saghen/blink.cmp',
    -- see above for full list of optional dependencies ☝️
  },
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    workspaces = {
      {
        name = 'Vault',
        path = '~/obsidian/Vault/',
      },
    },

    -- Disable legacy commands to avoid deprecation warnings
    legacy_commands = false,

    -- Configure note ID generation to use title
    note_id_func = function(title)
      if title ~= nil then
        -- Clean title: lowercase, replace spaces with hyphens, remove special chars
        return title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
      else
        -- Fallback to timestamp if no title
        return tostring(os.time())
      end
    end,

    -- Configure note path to use cleaned title as filename
    note_path_func = function(spec)
      local title = spec.title or spec.id
      local clean_title = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
      return spec.dir / (clean_title .. '.md')
    end,

    templates = {
      folder = 'templates',
      date_format = '%Y-%m-%d',
      time_format = '%H:%M',
      substitutions = {
        datetime = function() return os.date '%Y-%m-%d %H:%M' end,
      },
    },

    -- Don't add id to frontmatter, preserve created from template
    note_frontmatter_func = function(note)
      local out = {}

      -- Keep aliases
      if note.aliases and #note.aliases > 0 then
        out.aliases = note.aliases
      else
        out.aliases = {}
      end

      -- Keep tags
      if note.tags and #note.tags > 0 then
        out.tags = note.tags
      else
        out.tags = {}
      end

      -- Preserve created field if it exists (from template)
      if note.metadata and note.metadata.created then out.created = note.metadata.created end

      return out
    end,

    completion = {
      nvim_cmp = false,
      blink = true,
      min_chars = 2,
    },
  },
  config = function(_, opts)
    require('obsidian').setup(opts)

    local function map(mode, lhs, rhs, desc) vim.keymap.set(mode, lhs, rhs, { desc = desc, silent = true }) end

    -- Core note operations (using correct command format with underscores)
    map('n', '<leader>on', '<cmd>Obsidian new<cr>', 'New note')
    map('n', '<leader>oN', '<cmd>Obsidian new_from_template<cr>', 'New note from template')
    map('n', '<leader>oo', '<cmd>Obsidian open<cr>', 'Open note')
    map('n', '<leader>oq', '<cmd>Obsidian quick_switch<cr>', 'Quick switch notes')

    -- Search and find
    map('n', '<leader>of', '<cmd>Obsidian search<cr>', 'Search notes')
    map('n', '<leader>ob', '<cmd>Obsidian backlinks<cr>', 'Show backlinks')
    map('n', '<leader>ol', '<cmd>Obsidian links<cr>', 'Show all links')
    map('n', '<leader>ot', '<cmd>Obsidian tags<cr>', 'Browse tags')

    -- Daily notes
    map('n', '<leader>od', '<cmd>Obsidian today<cr>', "Today's note")
    map('n', '<leader>oy', '<cmd>Obsidian yesterday<cr>', "Yesterday's note")
    map('n', '<leader>om', '<cmd>Obsidian tomorrow<cr>', "Tomorrow's note")
    map('n', '<leader>oD', '<cmd>Obsidian dailies<cr>', 'Browse daily notes')

    -- Link operations
    map('n', '<leader>oL', '<cmd>Obsidian link<cr>', 'Create link from selection')
    map('v', '<leader>oL', '<cmd>Obsidian link<cr>', 'Create link from selection')
    map('n', '<leader>oF', '<cmd>Obsidian link_new<cr>', 'Create new note and link')
    map('v', '<leader>oF', '<cmd>Obsidian link_new<cr>', 'Create new note and link')
    map('n', '<leader>og', '<cmd>Obsidian follow_link<cr>', 'Follow link under cursor')

    -- Templates and workspace
    map('n', '<leader>oT', '<cmd>Obsidian template<cr>', 'Insert template')
    map('n', '<leader>ow', '<cmd>Obsidian workspace<cr>', 'Switch workspace')

    -- Utility
    map('n', '<leader>or', '<cmd>Obsidian rename<cr>', 'Rename note')
    map('n', '<leader>ox', '<cmd>Obsidian extract_note<cr>', 'Extract note from selection')
    map('v', '<leader>ox', '<cmd>Obsidian extract_note<cr>', 'Extract note from selection')
    map('n', '<leader>op', '<cmd>Obsidian paste_img<cr>', 'Paste image')
    map('n', '<leader>oc', '<cmd>Obsidian toggle_checkbox<cr>', 'Toggle checkbox')

    -- Advanced API shortcuts (using Lua functions)
    map('n', '<leader>oS', function()
      local client = require('obsidian').get_client()
      local picker = client:picker()
      if picker then picker:find_notes() end
    end, 'Smart note finder')

    map('n', '<leader>oR', function()
      local client = require('obsidian').get_client()
      local note = client:current_note()
      if note then
        local backlinks = client:find_backlinks(note)
        if #backlinks > 0 then
          vim.notify('Found ' .. #backlinks .. ' backlinks')
        -- You could open a picker here to select from backlinks
        else
          vim.notify 'No backlinks found'
        end
      end
    end, 'Find backlinks for current note')

    map('n', '<leader>oi', function()
      local client = require('obsidian').get_client()
      local note = client:current_note()
      if note then
        local info = note:display_info()
        vim.notify(info, vim.log.levels.INFO)
      end
    end, 'Show note info')

    -- Custom keymap for tab folding in markdown (replaces deprecated mappings config)
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'markdown',
      callback = function()
        vim.keymap.set('n', '<tab>', function()
          if vim.fn.foldlevel '.' > 0 then
            if vim.fn.foldclosed '.' == -1 then
              vim.cmd 'foldclose'
            else
              vim.cmd 'foldopen'
            end
          end
        end, { buffer = true, desc = 'Toggle fold' })
      end,
    })
  end,
}
