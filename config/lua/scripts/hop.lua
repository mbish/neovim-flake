local setup = function() 
    require("hop").setup()
end

local keys = {
    {"<c-l>", require("hop").hint_words, mode="n", desc = "Hop to word"},
}

local lazy = function ()
    return {
        "hop.nvim",
        keys = keys,
        after = setup,
    }
end

return  {
    lazy = lazy,
}
