local lspconfig = require("lspconfig")
local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
local settings = {
    ["rust-analyzer"] = {
        checkOnSave = {
            command = "clippy",
            extraArgs = {
                "--",
                "--no-deps",
                "-Dclippy::correctness",
                "-Dclippy::complexity",
                "-Wclippy::perf",
                "-Wclippy::pedantic",
            },
        },
        cargo = {
            allFeatures = true,
        },
        diagnostics = {
            enable = true,
            disabled = { "unresolved-proc-macro" },
        },
        inlayHints = {
            bindingModeHints = {
                enable = true,
            },
            closureReturnTypeHints = {
                enable = true,
            },
            lifetimeElisionHints = {
                enable = true,
            },
        },
    },
}

lspconfig.rust_analyzer.setup({
    capabilities = lsp_capabilities,
    settings = settings,
})
