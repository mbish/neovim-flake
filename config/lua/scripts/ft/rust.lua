vim.api.nvim_create_autocmd("FileType", {
    pattern = "rust",
    callback = function()
        vim.keymap.set("n", "<leader>la", "<CMD>RustLsp codeAction<CR>", { desc = "Code actions", buffer = bufnr })
        vim.keymap.set("n", "<leader>le", "<CMD>RustLsp explainError<CR>", { desc = "Explain Error", buffer = bufnr })
        vim.keymap.set(
            "n",
            "<leader>ld",
            "<CMD>RustLsp relatedDiagnostics<CR>",
            { desc = "Related Diagnostics", buffer = bufnr }
        )
    end,
})
