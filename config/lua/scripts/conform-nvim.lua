local setup = function()
    local conform = require("conform")
    conform.setup({
        formatters = {
            stylua = {
                prepend_args = { "--indent-type", "Spaces", "--indent-width", "4" },
            },
            cargo_fmt = {
                command = "carg",
                args = { "fmt" }
            }
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
            c = { "clang-format" },
            cpp = { "clang-format" },
            yaml = { "yamlfix" },
            go = { "gofmt" },
            rust = { "cargo_fmt" },
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
                timeout_ms = 500,
            }
        end
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
        desc = "Format buffer"
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
