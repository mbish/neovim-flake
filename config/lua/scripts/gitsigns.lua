local setup = function()
    require('gitsigns').setup()
end

local lazy = function()
    return {
        "gitsigns.nvim",
        after = setup,
    }
end

return {
    lazy = lazy,
}
