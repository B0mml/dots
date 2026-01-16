-- ==========================================
-- Neovim Configuration - Refactored & Clean
-- ==========================================

-- Initialize core configuration
require('core').setup()

-- Load additional configurations
require('config.neovide').setup()
-- vim: ts=2 sts=2 sw=2 et

local port = os.getenv 'GDScript_Port' or '6005'
local cmd = vim.lsp.rpc.connect('127.0.0.1', tonumber(port))

vim.lsp.config('gdscript', {
  cmd = cmd,
  filetypes = { 'gd', 'gdscript', 'gdscript3' },
  root_markers = { 'project.godot', '.git' },
})
vim.lsp.enable 'gdscript'

