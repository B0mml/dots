-- Core Vim options and settings
local M = {}

function M.setup()
  -- Leader keys (must be set before plugins)
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ','

  -- Font configuration
  vim.g.have_nerd_font = true

  -- Set PowerShell as default shell for Windows
  if vim.fn.has 'win32' == 1 then
    vim.o.shell = 'powershell'
    vim.o.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command'
    vim.o.shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    vim.o.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    vim.o.shellquote = ''
    vim.o.shellxquote = ''
  end

  -- Editor options
  vim.o.number = true
  vim.o.relativenumber = true
  vim.o.tabstop = 4
  vim.o.shiftwidth = 4
  vim.o.mouse = 'a'
  vim.o.showmode = false

  -- Sync clipboard between OS and Neovim
  vim.o.clipboard = 'unnamedplus'

  -- Text editing
  vim.o.breakindent = true
  vim.o.undofile = true
  vim.o.ignorecase = true
  vim.o.smartcase = true

  -- UI options
  vim.o.signcolumn = 'yes'
  vim.o.updatetime = 250
  vim.o.timeoutlen = 300
  vim.o.splitright = true
  vim.o.splitbelow = true
  vim.o.cursorline = true
  vim.o.scrolloff = 10
  vim.o.confirm = true

  -- List characters
  vim.o.list = true
  vim.opt.listchars = { tab = '│ ', trail = '·', nbsp = '␣' }

  -- Preview substitutions live
  vim.o.inccommand = 'split'
end

return M
