return {
  "norcalli/nvim-colorizer.lua",
  version = "*",
  config = function()
    require('colorizer').setup {
      'html';
      'css';
    }
  end,
}
