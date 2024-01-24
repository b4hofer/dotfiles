return {
    "theprimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("harpoon"):setup()
    end,
    keys = {
      { "<leader>ha", function() require("harpoon"):list():append() end, desc = "harpoon file", },
      { "<leader>he", function() local harpoon = require("harpoon") harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "harpoon quick menu", },
      { "<M-h>", function() require("harpoon"):list():select(1) end, desc = "Harpoon to file 1", },
      { "<M-j>", function() require("harpoon"):list():select(2) end, desc = "Harpoon to file 2", },
      { "<M-k>", function() require("harpoon"):list():select(3) end, desc = "Harpoon to file 3", },
      { "<M-l>", function() require("harpoon"):list():select(4) end, desc = "Harpoon to file 4", },
    },
  }
