vim.g.mapleader = " "

vim.keymap.set("n", "-", "<CMD>bp<CR>", { desc = "Previous buffer" } )
vim.keymap.set("n", "=", "<CMD>bn<CR>", { desc = "Next buffer" } )
vim.keymap.set("n", "<C-d>" , ":w<CR>", { desc = "Save buffer" } )
vim.keymap.set("n", "<leader>k" , "\"zyiw :Rg <C-r>z<CR>", { desc = "Search word under cursor" } )
vim.keymap.set("n", "<C-p>" , "<Esc>:Rg ", { desc = "Search in project" } )
vim.keymap.set("n", "<leader>L" , "<cmd> Lines<CR>", { desc = "Search lines" } )
vim.keymap.set("n", "c/" , ":nohlsearch<CR>", { desc = "Clear search highlight" })
vim.keymap.set("n", "<F4>" , ":SymbolsOutline<CR>", { desc = "Toggle symbols outline" } )
vim.keymap.set("n", "<leader>ad" , "<cmd>let g:formatsave,v:false<CR>", { desc = "Disable auto-format on save" })
vim.keymap.set("n", "<leader>ae" , "<cmd>let g:formatsave,v:true<CR>", { desc = "Enable auto-format on save" })
vim.keymap.set("n", "<C-n>" , "/", { desc = "Search in current buffer" })
