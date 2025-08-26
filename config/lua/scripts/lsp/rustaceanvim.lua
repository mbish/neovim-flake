local bufnr = vim.api.nvim_get_current_buf()

vim.keymap.set("n", "<leader>ca", function()
    vim.cmd.RustLsp("codeAction")
end, { buffer = bufnr }, { desc = "Code actions" })

vim.g.rustaceanvim = {
    -- LSP configuration
    server = {
        default_settings = {
            -- rust-analyzer language server configuration
            ["rust-analyzer"] = {
                checkOnSave = true,
                check = {
                    command = "cargo",
                    extraArgs = {
                        "clippy",
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
        },
    },
}
