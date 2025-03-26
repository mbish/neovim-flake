local setup = function()
    require("symbols-outline").setup()
end

local keys = {
    {"<F4>" , "<cmd>SymbolsOutline<CR>", { silent = true, desc = "Toggle symbols outline" }}
}

local lazy = function()
    return {
        "symbols-outline.nvim",
        after = setup,
        keys = keys,
    }
end

return {
    lazy = lazy,
}
