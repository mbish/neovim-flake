vim.g.vimwiki_key_mappings = { all_maps = 0 }
vim.keymap.set("n", "<leader>ww", "<cmd>VimwikiIndex<CR>", { silent = true })

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = {
        "*.wiki",
        "*.md",
    },
    callback = function (opts)
        vim.keymap.set("n", "<CR>", "<cmd>VimwikiFollowLink<CR>", { buffer = true, silent = true })
        vim.keymap.set("n", "<BS>", "<cmd>VimwikiGoBackLink<CR>", { buffer = true, silent = true })
    end,
})

