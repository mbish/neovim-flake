local keys = {
    { "s", mode = { "n", "x", "o" }, function()
        require("flash").jump()
    end, desc = "Flash" },
}

local setup = function()
    require("flash").setup()
end

local lazy = function()
    return {
        "flash.nvim",
        after = setup,
        keys = keys
    }
end

return {
    lazy = lazy,
}
