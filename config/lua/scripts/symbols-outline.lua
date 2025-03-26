local setup = function()
    require("symbols-outline").setup()
end

local lazy = function()
    return {
        "symbols-outline.nvim",
        after = setup,
    }
end

return {
    lazy = lazy,
}
