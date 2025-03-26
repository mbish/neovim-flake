require("lz.n").load({
    { "vim-startuptime" },
    { "vim-fugitive" },
    require("scripts.telescope").lazy(),
    require("scripts.which-key").lazy(),
    require("scripts.symbols-outline").lazy(),
    require("scripts.bufferline").lazy(),
    require("scripts.lualine").lazy(),
    require("scripts.nvim-surround").lazy(),
    require("scripts.hop").lazy(),
    require("scripts.gitsigns").lazy(),
    require("scripts.conform-nvim").lazy(),
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
        "scripts.lsp.rust_analyzer",
        load = function()
            require("scripts.lsp.rust_analyzer")
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
})
