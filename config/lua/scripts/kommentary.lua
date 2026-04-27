local setup = function()
    require("kommentary")
end

local lazy = function()
    return {
        "kommentary",
        keys = {
            { "gc", mode = { "n", "v" } },
        },
        after = setup,
    }
end

return {
    lazy = lazy,
}
