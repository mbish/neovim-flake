local o = vim.opt

o.compatible = false
vim.cmd("autocmd!")
o.autoindent = true
o.autoread = true
o.autowrite = true
o.backspace="indent,eol,start"
o.clipboard="unnamedplus"
o.completeopt="menuone"
o.conceallevel=2
o.directory="/tmp"
o.expandtab = true
o.fillchars = "vert:│"
o.hidden = true
o.history= 50
o.hlsearch = true
o.incsearch = true
o.laststatus= 2
o.mouse = "a"
o.showmode = true
o.swapfile = false
o.number = true
o.ruler = true
o.shiftwidth = 4
o.softtabstop = 4
o.tabstop = 4
o.termguicolors = true
o.timeoutlen = 500
o.undodir = "/tmp/vim/undodir"
o.undofile = true
o.updatetime = 500
o.wildmode = "list:longest,full"
o.modeline = false

vim.cmd([[
    filetype plugin on
]])

vim.cmd.colorscheme("slate")
