require("nvim-treesitter-textobjects").setup({
    select = {
        lookahead = true,
    },
})

local select_textobject = function(capture, query_group)
    return function()
        require("nvim-treesitter-textobjects.select").select_textobject(capture, query_group)
    end
end

local keymaps = {
    ["af"] = { "@function.outer", "Select all of function" },
    ["if"] = { "@function.inner", "Select inner function" },
    ["ac"] = { "@class.outer", "Select all of class" },
    ["ic"] = { "@class.inner", "Select inner of class" },
    ["aS"] = { "@statement.outer", "Select statement" },
    ["aC"] = { "@call.outer", "Select outer call" },
    ["iC"] = { "@call.inner", "Select inner call" },
    ["il"] = { "@loop.inner", "Select inner loop" },
    ["al"] = { "@loop.outer", "Select outer loop" },
    ["ir"] = { "@return.inner", "Select inner return" },
    ["ar"] = { "@return.outer", "Select outer return" },
    ["aF"] = { "@function.name", "Select the function name" },
}

for key, mapping in pairs(keymaps) do
    vim.keymap.set({ "x", "o" }, key, select_textobject(mapping[1], "textobjects"), { desc = mapping[2] })
end
