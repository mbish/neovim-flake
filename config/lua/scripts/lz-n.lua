require("lz.n").load({
    { "vim-startuptime" },
    { "vim-fugitive" },
    require("scripts.telescope").lazy(),
    require("scripts.which-key").lazy(),
    require("scripts.symbols-outline").lazy(),
    require("scripts.bufferline").lazy(),
    require("scripts.lualine").lazy(),
    require("scripts.nvim-surround").lazy(),
    require("scripts.gitsigns").lazy(),
    require("scripts.conform-nvim").lazy(),
})
require("lz.n").load(require("scripts.lsp"))
