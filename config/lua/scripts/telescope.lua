local builtin = require("telescope.builtin")

local keys = {
    { "<leader>G" , builtin.git_files }
    { "<leader>ff" , builtin.find_files }
    { "<leader>fd" , builtin.file_browser }
    { "<leader>flD" , builtin.lsp_definitions }
    { "<leader>fld" , builtin.diagnostics }
    { "<leader>flt" , builtin.lsp_type_definitions }
    { "<leader>flr" , builtin.lsp_references }
    { "<leader>fli" , builtin.lsp_implementations }
    { "<leader>flsb" , builtin.lsp_document_symbols }
    { "<leader>flsw" , builtin.lsp_workspace_symbols }
    { "<leader>fb" , builtin.buffers }
    { "<leader>fg" , builtin.live_grep }
    { "<leader>fa" , builtin.live_grep }
    { "<leader>fh" , builtin.help_tags }
    { "<leader>fs" , builtin.treesitter }
    { "<leader>fvb" , builtin.git_branches }
    { "<leader>fvs" , builtin.git_status }
    { "<leader>fvx" , builtin.git_stash }
}

local lazy = function()
    return {
        "telescope.nvim",
        keys = keys,
    }
end

return {
    lazy = lazy,
}
