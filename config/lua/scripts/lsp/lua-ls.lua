local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("lua_ls", {
    capabilities = lsp_capabilities,
})
vim.lsp.enable("lua_ls")
