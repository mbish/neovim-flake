local setup = function()
    require("which-key").add({})
end

opts = {
    icons = {
        mappings = false,
    },
}
keys = {
    {
        "<leader>?",
        function()
            require("which-key").show({ global = true })
        end,
        desc = "Show all keymaps",
    },
    { "<leader>f", desc = "Find" },
    { "<leader>t", desc = "Test" },
    { "<leader>u", desc = "Utilities" },
    { "<leader>a", desc = "Auto-action settings" },
    { "<leader>c", desc = "LSP Commands" },
    { "<leader>s", desc = "Setting" },
    { "<leader>sa", desc = "AI Setting" },
    { "<leader>w", desc = "Vimwiki" },
    { "<leader>y", desc = "Copy shortcuts" },
}

local lazy = function()
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
