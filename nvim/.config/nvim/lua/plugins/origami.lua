return {
  'chrisgrieser/nvim-origami',
  event = 'BufReadPost',
  config = function()
    -- LSP folding (best option)
    vim.o.foldmethod = 'expr'
    vim.o.foldexpr = 'v:lua.vim.lsp.foldexpr()'

    -- Fold settings
    vim.o.foldcolumn = '1'
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    -- Setup origami
    require('origami').setup {
      pauseFoldsOnSearch = true,
      isDisabledBuffer = function(bufnr)
        local buftype = vim.api.nvim_get_option_value('buftype', { buf = bufnr })
        local filetype = vim.api.nvim_get_option_value('filetype', { buf = bufnr })
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        return buftype ~= '' or filetype == '' or bufname:find 'Neogit' ~= nil or bufname:find 'COMMIT_EDITMSG' ~= nil
      end,
    }
    vim.keymap.set('n', 'zR', function() vim.cmd 'normal! zR' end, { desc = 'Open all folds' })
    vim.keymap.set('n', 'zM', function() vim.cmd 'normal! zM' end, { desc = 'Close all folds' })
  end,
}
