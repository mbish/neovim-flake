local opts = {
    outline_window = {
        position = "right";
    },
    symbols = {
        icon_fetcher = function() return "" end,
    },
    symbol_folding = {
        markers = { "+", "-" },
    }
}

local setup = function()
    require("outline").setup(opts)
end

local keys = {
    {"<leader>o" , "<cmd>Outline<CR>", { silent = true, desc = "Toggle symbols outline" }}
}

local lazy = function()
    return {
        "outline.nvim",
        after = setup,
        keys = keys,
        opts = opts,
    }
end

return {
    lazy = lazy,
}
