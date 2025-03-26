require("nvim-treesitter.configs").setup({
    sync_install = false,
    auto_install = false,
    highlight = {
        enable = true,
        -- disable = table/function
        additional_vim_regex_highlighting = true,
    },
    indent = { enable = true },

    playground = {
        enable = true,
        disable = {},
        updatetime = 25,
        persist_queries = false,
        keybindings = {},
    },
    indent = {
        enable = true,
    },
})

require('ts_context_commentstring').setup {}
vim.g.skip_ts_context_commentstring_module = true
