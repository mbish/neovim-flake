local textobjects = {
    select = {
        enable = true,
        lookahead = true,
        keymaps = {
            ["af"] = { query = "@function.outer", desc = "Select all of function" },
            ["if"] = { query = "@function.inner", desc = "Select inner function" },
            ["ac"] = { query = "@class.outer", desc = "Select all of class" },
            ["ic"] = { query = "@class.inner", desc = "Select inner of class" },
            ["aS"] = { query = "@statement.outer", desc = "Select statement" },
            ["aC"] = { query = "@call.outer", desc = "Select outer call" },
            ["iC"] = { query = "@call.inner", desc = "Select inner call" },
            ["il"] = { query = "@loop.inner", desc = "Select inner loop" },
            ["al"] = { query = "@loop.outer", desc = "Select outer loop" },
            ["ir"] = { query = "@return.inner", desc = "Select inner return" },
            ["ar"] = { query = "@reutrn.outer", desc = "Select outer return" },
            ["aF"] = { query = "@function.name", desc = "Select the function name" },

        }
    }
}

require("nvim-treesitter.configs").setup({
    sync_install = false,
    auto_install = false,
    highlight = {
        enable = true,
        -- disable = table/function
        additional_vim_regex_highlighting = true,
    },
    indent = { enable = false },

    playground = {
        enable = true,
        disable = {},
        updatetime = 25,
        persist_queries = false,
        keybindings = {},
    },
    textobjects = textobjects,
})

require('ts_context_commentstring').setup {}
vim.g.skip_ts_context_commentstring_module = true
