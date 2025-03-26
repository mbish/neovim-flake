vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.keymap.set("n", "-", "<CMD>bp<CR>", { desc = "Previous buffer" } )
vim.keymap.set("n", "=", "<CMD>bn<CR>", { desc = "Next buffer" } )
vim.keymap.set("n", "<C-d>" , ":w<CR>", { desc = "Save buffer" } )
vim.keymap.set("n", "c/" , ":nohlsearch<CR>", { desc = "Clear search highlight" })
vim.keymap.set("n", "<leader>ad" , "<cmd>let g:disable_autoformat=v:true<CR>", { desc = "Disable auto-format on save" })
vim.keymap.set("n", "<leader>ae" , "<cmd>let g:disable_autoformat=v:false<CR>", { desc = "Enable auto-format on save" })
vim.keymap.set("n", "<C-n>" , "/", { desc = "Search in current buffer" })

vim.keymap.set("i", "<C-k>", "<Esc>", { desc = "Normal Mode", remap = false})
vim.keymap.set("i", "<C-d>", "<Esc>:w<CR>", { desc = "Save buffer", remap = false })
