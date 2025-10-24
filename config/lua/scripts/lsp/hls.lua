local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("hls", {
    capabilities = lsp_capabilities,
    on_attach = function(client, bufnr, ht)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        local ht = require("haskell-tools")
        vim.keymap.set("n", "<leader>hs", ht.hoogle.hoogle_signature, opts)
    end,
    cmd = { "haskell-language-server-wrapper", "--lsp", "-j", "2" },
    root_dir = lspconfig.util.root_pattern("hie.yaml", "stack.yaml", ".cabal", "cabal.project", "project.yaml"),
})
