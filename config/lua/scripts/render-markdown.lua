vim.treesitter.language.register('markdown', 'vimwiki')

require('render-markdown').setup({
    file_types = { 'markdown', 'vimwiki' },
})
