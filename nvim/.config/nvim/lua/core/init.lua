-- Core module initialization
local M = {}

function M.setup()
  require('core.options').setup()
  require('core.keymaps').setup()
  require('core.autocmds').setup()
  require('core.lazy').setup()

  -- Load plugins
  require('core.lazy').load_plugins()
end

return M

