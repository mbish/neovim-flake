local setup = function()
    local conform = require("conform")
    conform.setup({
        formatters = {
            stylua = {
                prepend_args = { "--indent-type", "Spaces", "--indent-width", "4" },
            },
            qmkfmt = {
                command = "qmkfmt",
                arg = { "$FILENAME" },
                condition = function(self, ctx)
                    return vim.fs.basename(ctx.filename) == "keymap.c"
                end,
                inherit = false,
            },
            --[[ vimwiki = {
                args = { "--prose-wrap", "always", "-w", "--parser", "markdown", "$FILENAME" },
                command = "prettier",
                stdin = false,
            }, ]]
        },
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "isort", "black" },
            nix = { "nixfmt" },
            javascript = { "prettier" },
            javascriptreact = { "prettier" },
            typescript = { "prettier" },
            typescriptreact = { "prettier" },
            json = { "prettier" },
            html = { "prettier" },
            css = { "prettier" },
            markdown = { "prettier" },
            -- vimwiki = { "vimwiki" },
            c = { "qmkfmt", "clang-format", stop_after_first = true },
            cpp = { "clang-format" },
            yaml = { "yamlfix" },
            go = { "gofmt" },
            rust = { "rustfmt" },
            bash = { "shfmt" },
            sh = { "shfmt" },
            zsh = { "shfmt" },
        },
        format_on_save = function(bufnr)
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
            end
            return {
                lsp_format = "fallback",
                timeout_ms = 1000,
            }
        end,
    })
end

local keys = {
    {
        "<localleader>f",
        function()
            require("conform").format({
                bufnr = vim.api.nvim_get_current_buf(),
            })
        end,
        desc = "Format buffer",
    },
}

local lazy = function()
    return {
        "conform.nvim",
        after = setup,
        keys = keys,
    }
end

return {
    lazy = lazy,
}
