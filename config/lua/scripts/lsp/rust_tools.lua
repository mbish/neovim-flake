local rt = require("rust-tools")
local settings = {
    ["rust-analyzer"] = {
        checkOnSave = true,
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

rt.setup({
    server = {
        on_attach = function(_, bufnr)
            -- Hover actions
            vim.keymap.set(
                "n",
                "<leader>ch",
                rt.hover_actions.hover_actions,
                { buffer = bufnr },
                { desc = "Hover actions" }
            )
            -- Code action groups
            vim.keymap.set(
                "n",
                "<leader>ca",
                rt.code_action_group.code_action_group,
                { buffer = bufnr },
                { desc = "Code actions" }
            )
            -- Documentation Lookup
            vim.opt.keywordprog="rusty-man"
        end,
        settings = settings,
    },
    tools = {
        autoSetHints = true,
        hover_with_actions = false,
        inlay_hints = {
            only_current_line = false,
        },
    },
})
