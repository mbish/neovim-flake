local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("nixd", {
    capabilities = lsp_capabilities,
})
vim.lsp.enable("nixd")
