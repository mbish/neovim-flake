local api = vim.api

vim.cmd([[
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
vim.keymap.set(
    "n",
    "<leader>ut",
    ":call StripTrailingWhitespace()<CR>",
    { desc = "Strip trailing whitespace", silent = true }
)

function trimStartOfLines(str)
    local lines = {}
    for line in str:gmatch("[^\r\n]+") do
        local trimmed = line:match("^%s*(.-)$")
        table.insert(lines, trimmed)
    end
    return table.concat(lines, "\n")
end

local trimAndCopy = function()
    -- Yank the visual selection
    api.nvim_command("normal! y")

    -- Get the yanked text
    local yanked_text = vim.fn.getreg('"')

    -- Trim the leading whitespace
    local trimmed_text = trimStartOfLines(yanked_text)

    -- Set the register to the trimmed text
    vim.fn.setreg("*", trimmed_text)
end

-- Map the function to Ctrl + c in visual mode
vim.keymap.set("v", "Y", trimAndCopy, { silent = true })
