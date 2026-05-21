require("ts_context_commentstring").setup({})
vim.g.skip_ts_context_commentstring_module = true
vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        local lang = vim.treesitter.language.get_lang(args.match)
        if lang and pcall(vim.treesitter.language.inspect, lang) then
            vim.treesitter.start(args.buf)
        end
    end,
})
