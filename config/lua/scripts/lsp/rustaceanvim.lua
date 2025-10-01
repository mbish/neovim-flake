local bufnr = vim.api.nvim_get_current_buf()
local wk = require("which-key")

wk.add({
    {
        "<leader>ca",
        function()
            vim.cmd.RustLsp("codeAction")
        end,
        mode = "n",
        buffer = bufnr,
        desc = "Code actions",
    },
})

wk.add({
    {
        "<leader>ce",
        function()
            vim.cmd.RustLsp("explainError")
        end,
        mode = "n",
        buffer = bufnr,
        desc = "Explain Error",
    },
})

wk.add({
    {
        "<leader>cd",
        function()
            vim.cmd.RustLsp("relatedDiagnostics")
        end,
        mode = "n",
        buffer = bufnr,
        desc = "Related Diagnostics",
    },
})

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
