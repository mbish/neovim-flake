local setup = function()
    require("which-key").add({
      { "<leader>f", group = "Find" },
      { "<leader>t", group = "Test" },
      { "<leader>u", group = "Utilities" },
      { "<leader>a", group = "Auto-action settings" },
      { "<leader>c", group = "LSP Commands" },
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
