local wk = require("which-key")
local bufnr = vim.api.nvim_get_current_buf()

vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.keymap.set("i", "<C-d>", "<Esc>:w<CR>", { desc = "Save buffer", remap = false })
vim.keymap.set("i", "<C-k>", "<Esc>", { desc = "Normal Mode", remap = false })
vim.keymap.set("n", "-", "<CMD>bp<CR>", { remap = false, desc = "Previous buffer" })
vim.keymap.set("n", "<C-d>", ":w<CR>", { desc = "Save buffer" })
vim.keymap.set("n", "<C-n>", "/", { desc = "Search in current buffer" })
vim.keymap.set("n", "<leader>ad", "<cmd>let g:disable_autoformat=v:true<CR>", { desc = "Disable auto-format on save" })
vim.keymap.set("n", "<leader>ae", "<cmd>let g:disable_autoformat=v:false<CR>", { desc = "Enable auto-format on save" })
vim.keymap.set("n", "<leader>x", "<cmd>wqa<CR>", { desc = "Write all and exit" })
vim.keymap.set("n", "<leader>yf", "<cmd>let @* = expand('%')<CR>", { desc = "Copy file path to clipboard" })
vim.keymap.set("n", "=", "<CMD>bn<CR>", { remap = false, desc = "Next buffer" })
vim.keymap.set("n", "c/", ":nohlsearch<CR>", { desc = "Clear search highlight" })
vim.keymap.set("n", "<leader>lr", function()
    vim.lsp.buf.rename()
end, { desc = "Rename symbol" })
vim.keymap.set("n", "s", "<Plug>(leap)", { desc = "Leap to char", remap = false })

wk.add({
    {
        "<leader>ca",
        function()
            vim.cmd.RustLsp("codeAction")
        end,
        mode = "n",
        buffer = bufnr,
        desc = "Code actions",
    },
})

wk.add({
    {
        "<leader>ce",
        function()
            vim.cmd.RustLsp("explainError")
        end,
        mode = "n",
        buffer = bufnr,
        desc = "Explain Error",
    },
})

wk.add({
    {
        "<leader>cd",
        function()
            vim.cmd.RustLsp("relatedDiagnostics")
        end,
        mode = "n",
        buffer = bufnr,
        desc = "Related Diagnostics",
    },
})
