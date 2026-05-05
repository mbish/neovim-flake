vim.g.vimwiki_key_mappings = { all_maps = 0 }
local setup = function()
    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
        pattern = {
            "*.wiki",
            "*.md",
        },
        callback = function (opts)
            vim.opt_local.spell = true
            vim.keymap.set("n", "<CR>", "<cmd>VimwikiFollowLink<CR>", { buffer = true, silent = true })
            vim.keymap.set("n", "<BS>", "<cmd>VimwikiGoBackLink<CR>", { buffer = true, silent = true })
        end,
    })
end

local keys = {
    {"<leader>ww", "<cmd>VimwikiIndex<CR>", mode = { "n" }, { silent = true, desc = "Open Vimwiki index" }},
}

local lazy = function()
    return {
        "vimwiki",
        after = setup,
        keys = keys,
    }
end

return {
    lazy = lazy,
}
