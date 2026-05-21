vim.g.rustaceanvim = {
    server = {
        default_settings = {
            ["rust-analyzer"] = {
                checkOnSave = true,
                cargo = {
                    allFeatures = true,
                },
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
    },
}
