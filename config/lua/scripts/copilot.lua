vim.g.copilot_no_tab_map = true
vim.keymap.set("i", "<c-f>", 'copilot#Accept("\\<CR>\")', { expr = true, replace_keycodes = false, desc = "Accept AI Suggestion", silent = true })
