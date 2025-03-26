local setup = function()
    local conform = require("conform")
    conform.setup({
        formatters = {
            stylua = {
                prepend_args = { "--indent-type", "Spaces", "--indent-width", "4" },
            },
        },
        formatters_by_ft = {
            lua = { "stylua" },
            python = { "isort", "black" },
            nix = { "nixfmt" },
            javascript = { "prettierd" },
            javascriptreact = { "prettierd" },
            typescript = { "prettierd" },
            typescriptreact = { "prettierd" },
            json = { "prettierd" },
            c = { "clang-format" },
            cpp = { "clang-format" },
            yaml = { "yamlfix" },
            go = { "gofmt" },
            rust = { "rustfmt" },
            haskell = { "" },
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
