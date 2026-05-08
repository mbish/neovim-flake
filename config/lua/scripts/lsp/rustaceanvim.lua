local bufnr = vim.api.nvim_get_current_buf()

local cargo_check_config = {
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
}

local clippy_config = {
    checkOnSave = false,
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
}

vim.g.rustaceanvim = {
    -- LSP configuration
    server = {
        default_settings = {
            -- rust-analyzer language server configuration
            ["rust-analyzer"] = cargo_check_config,
        },
    },
}

vim.keymap.set("n", "<leader>cl", function()
    vim.cmd("RustLsp config %s", clippy_config)
    vim.cmd("RustLsp flyCheck")
end, { desc = "Toggle Clippy/Check Diagnostics" })
