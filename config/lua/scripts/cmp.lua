local cmp = require('cmp')

local sources = {
    { name = 'path' },
    { name = "nvim_lsp", keyword_length = 1 },
    { name = "buffer", keyword_length = 3 }, -- text within current buffer
    { name = "luasnip", keyword_length = 2 }, -- snippets
    { name = "nvim_lsp_signature_help", keyword_length = 1 }, -- snippets
}

local completion = {
    completeopt = "menu,menuone,preview,noselect",
}

local mappings = function(cmp, select_opts)
    return {
        ["<c-p>"] = cmp.mapping.select_prev_item(select_opts),
        ["<c-n>"] = cmp.mapping.select_next_item(select_opts),
        ["<c-e>"] = cmp.mapping.abort(),
        ['<c-d>'] = cmp.mapping.confirm({ select = true }),
    }
end

cmp.setup {
  completion = completion,
  sources = sources,
  mapping = cmp.mapping.preset.insert(mappings(cmp, select_opts)),
}
