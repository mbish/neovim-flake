local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("gdscript", {
    capabilities = lsp_capabilities,
})
