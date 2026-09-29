vim.g.rustaceanvim = {
    server = {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        default_settings = {
            ["rust-analyzer"] = {
                cargo = {
                    allFeatures = true,
                },
                check = {
                    command = "check",
                    -- extraArgs = { "--target-dir", "target/analyzer" },
                },
                diagnostics = {
                    enable = true,
                    disabled = { "unresolved-proc-macro", "inactive-code" },
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
        },
    },
}
