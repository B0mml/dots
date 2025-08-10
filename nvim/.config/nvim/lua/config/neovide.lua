local M = {}

function M.setup()
  if vim.g.neovide then
    vim.g.neovide_fullscreen = false
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_refresh_rate = 144

    local function toggle_neovide_fullscreen()
      vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
      print('Neovide fullscreen: ' .. (vim.g.neovide_fullscreen and 'ON' or 'OFF'))
    end

    vim.keymap.set('n', '<leader>uF', toggle_neovide_fullscreen, {
      desc = 'Toggle Neovide fullscreen',
    })

    vim.cmd.colorscheme 'tokyonight-storm'
  else
    vim.cmd.colorscheme 'nordic'
  end
end

return M

