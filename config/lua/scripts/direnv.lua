vim.cmd ([[
    if filereadable($DIRENV_EXTRA_VIMRC)
     source $DIRENV_EXTRA_VIMRC
    endif
]])
