vim.cmd ([[
    function StripTrailingWhitespace()
       " Preparation: save last search, and cursor position.
       let l:_s=@/
       let l:l = line('.')
       let l:c = col('.')
       " Do the business:
       %s/\s\+$//e
       " Clean up: restore previous search history, and cursor position
       let @/=l:_s
       call cursor(l:l, l:c)
    endfunction
]])
vim.keymap.set("n", "<leader>t", ":call StripTrailingWhitespace()<CR>", { desc = "Strip trailing whitespace", silent = true })
