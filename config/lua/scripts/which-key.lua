local setup = function()
    require("which-key").add({
      { "<leader>f", group = "Find" },
      { "<leader>a", group = "Auto-action settings" },
    })
end

opts = {
    icons = {
        mappings = false,
    },
}
keys = {
    {
      "<leader>",
      function()
        require("which-key").show({ keys = "<leader>", global = true })
      end,
      desc = "Show leader keymaps"
    },
    {
      "<leader>?",
      function()
        require("which-key").show({ global = true })
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
