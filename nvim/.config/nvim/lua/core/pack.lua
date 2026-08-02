-- ==========================================
-- Neovim Package Manager (vim.pack) - Kickstart Style
-- ==========================================

local M = {}

local function gh(repo)
  return 'https://github.com/' .. repo
end

local function run_build(name, cmd, cwd)
  local result = vim.system(cmd, { cwd = cwd }):wait()
  if result.code ~= 0 then
    local stderr = result.stderr or ''
    local stdout = result.stdout or ''
    local output = stderr ~= '' and stderr or stdout
    if output == '' then output = 'No output from build command.' end
    vim.notify(('Build failed for %s:\n%s'):format(name, output), vim.log.levels.ERROR)
  end
end

function M.setup()
  -- Build hooks on PackChanged event
  vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
      local name = ev.data.spec.name
      local kind = ev.data.kind
      if kind ~= 'install' and kind ~= 'update' then return end

      if name == 'nvim-treesitter' then
        if not ev.data.active then vim.cmd.packadd 'nvim-treesitter' end
        vim.cmd 'TSUpdate'
        return
      end

      if name == 'LuaSnip' then
        if vim.fn.has 'win32' ~= 1 and vim.fn.executable 'make' == 1 then
          run_build(name, { 'make', 'install_jsregexp' }, ev.data.path)
        end
        return
      end
    end,
  })

  -- Install/load plugins using built-in vim.pack
  vim.pack.add({
    -- Core UX & Utilities
    gh 'NMAC427/guess-indent.nvim',
    gh 'lewis6991/gitsigns.nvim',
    gh 'folke/which-key.nvim',
    gh 'folke/todo-comments.nvim',
    gh 'nvim-lua/plenary.nvim',

    -- Colorschemes
    gh 'AlexvZyl/nordic.nvim',
    gh 'serhez/teide.nvim',

    -- Treesitter (stay on master branch for nvim-treesitter.configs & textobjects)
    { src = gh 'nvim-treesitter/nvim-treesitter', version = 'master' },
    gh 'nvim-treesitter/nvim-treesitter-textobjects',

    -- LSP & Mason
    gh 'neovim/nvim-lspconfig',
    gh 'mason-org/mason.nvim',
    gh 'mason-org/mason-lspconfig.nvim',
    gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
    gh 'j-hui/fidget.nvim',

    -- Completion & Snippets (v1.* for blink.cmp)
    gh 'saghen/blink.lib',
    { src = gh 'saghen/blink.cmp', version = 'v1.*' },
    gh 'L3MON4D3/LuaSnip',
    gh 'folke/lazydev.nvim',

    -- Formatting & Linting
    gh 'stevearc/conform.nvim',
    gh 'mfussenegger/nvim-lint',

    -- Snacks & UI
    gh 'folke/snacks.nvim',

    -- Additional Plugins
    gh 'windwp/nvim-autopairs',
    gh 'folke/flash.nvim',
    gh 'MagicDuck/grug-far.nvim',
    gh 'OXY2DEV/markview.nvim',
    gh 'echasnovski/mini.nvim',
    gh 'NickvanDyke/opencode.nvim',
    gh 'chrisgrieser/nvim-origami',
    gh 'stevearc/quicker.nvim',
    gh 'mrjones2014/smart-splits.nvim',
    gh 'S1M0N38/love2d.nvim',
  })

  -- Initialize plugin setups
  local plugins = {
    'colorschemes',
    'treesitter',
    'completion',
    'lsp',
    'formatting',
    'lint',
    'core',
    'snacks',
    'autopairs',
    'flash',
    'grug_far',
    'markview',
    'mini',
    'opencode',
    'origami',
    'quicker',
    'smartsplits',
    'love2d',
  }

  for _, plugin in ipairs(plugins) do
    local ok, mod = pcall(require, 'plugins.' .. plugin)
    if ok and type(mod) == 'table' and type(mod.setup) == 'function' then
      mod.setup()
    end
  end
end

return M
