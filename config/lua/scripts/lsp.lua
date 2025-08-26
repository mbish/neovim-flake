vim.cmd(
    [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor", source="always"})]]
)
return {
    {
        "scripts.lsp.pyright",
        load = function()
            require("scripts.lsp.pyright")
        end,
        ft = "python",
    },
    {
        "scripts.lsp.nixd",
        load = function()
            require("scripts.lsp.nixd")
        end,
        ft = "nix",
    },
    {
        "scripts.lsp.gopls",
        load = function()
            require("scripts.lsp.gopls")
        end,
        ft = { "go", "gomod" },
    },
    {
        "scripts.lsp.ccls",
        load = function()
            require("scripts.lsp.ccls")
        end,
        ft = { "c", "cpp", "objc", "objcpp", "cuda" },
    },
    {
        "scripts.lsp.ts_ls",
        load = function()
            require("scripts.lsp.ts_ls")
        end,
        ft = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
        },
    },
    {
        "scripts.lsp.lua-ls",
        load = function()
            require("scripts.lsp.lua-ls")
        end,
        ft = "lua",
    },
    {
        "scripts.lsp.rustaceanvim",
        load = function()
            require("scripts.lsp.rustaceanvim")
        end,
        ft = "rust",
    },
    {
        "scripts.lsp.hls",
        load = function()
            require("scripts.lsp.hls")
        end,
        ft = { "haskell", "cabal", "stack" },
    },
    {
        "scripts.lsp.gdscript",
        load = function()
            require("scripts.lsp.gdscript")
        end,
        ft = { "gd", "gdscript" },
    },
}
