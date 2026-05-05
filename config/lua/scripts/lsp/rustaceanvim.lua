local bufnr = vim.api.nvim_get_current_buf()

vim.g.rustaceanvim = {
    -- LSP configuration
    server = {
        default_settings = {
            -- rust-analyzer language server configuration
            ["rust-analyzer"] = {
                checkOnSave = true,
                check = {
                    command = "check",
                    extraArgs = {},
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
        },
    },
}
