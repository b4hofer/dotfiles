return {
  'famiu/bufdelete.nvim',
  config = function()
    vim.keymap.set('n', '<leader>x', ':Bdelete<CR>', { desc = 'Close buffer' })
  end,
}
