local which_key = require("which-key")
local setup = function()
    which_key.add({
      { "<leader>f", group = "Find" },
      { "<leader>a", group = "Auto-action settings" },
    })
end

opts = {}
keys = {
    {
      "<leader>",
      function()
        which_key.show({ keys = "<leader>", global = true })
      end,
      desc = "Show leader keymaps"
    },
    {
      "<leader>?",
      function()
        which_key.show({ global = true })
      end,
      desc = "Show all keymaps"
    },
}

local lazy = function () 
    return {
      "folke/which-key.nvim",
      after = setup,
      opts = opts,
      keys = keys,
    }
end

return {
    lazy = lazy,
}
