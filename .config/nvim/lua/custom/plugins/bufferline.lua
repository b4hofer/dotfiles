return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require('bufferline').setup {
      options = {
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            text_align = "center",
            separator = true
          }
        },
      },
    }

    -- Keymaps
    vim.keymap.set('n', '<Tab>', ":BufferLineCycleNext<CR>", { desc = 'Next buffer' })
    vim.keymap.set('n', '<S-Tab>', ":BufferLineCyclePrev<CR>", { desc = 'Previous buffer' })
  end,
}
