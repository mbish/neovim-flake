local builtin = require("telescope.builtin")

local keys = {
    { "<leader>G" , builtin.git_files, mode = "n", desc = "Git files" },
    { "<leader>ff" , builtin.find_files, mode = "n", desc = "Find files" },
    { "<leader>fd" , builtin.file_browser, mode = "n", desc = "File browser" },
    { "<leader>flD" , builtin.lsp_definitions, mode = "n", desc = "Definitions" },
    { "<leader>fld" , builtin.diagnostics, mode = "n", desc = "Diagnostics" },
    { "<leader>flt" , builtin.lsp_type_definitions, mode="n", desc = "Definitions" },
    { "<leader>flr" , builtin.lsp_references, mode="n", desc = "References" },
    { "<leader>fli" , builtin.lsp_implementations, mode="n", desc = "Implementations" },
    { "<leader>flsb" , builtin.lsp_document_symbols, mode="n", desc = "Buffer Symbols" },
    { "<leader>flsw" , builtin.lsp_workspace_symbols, mode="n", desc = "Workspace Symbols" },
    { "<leader>fb" , builtin.buffers, mode="n", desc = "Buffers" },
    { "<leader>fg" , builtin.live_grep, mode="n", desc = "Grep"  },
    { "<leader>fa" , builtin.live_grep_args, mode="n", desc = "Grep (args)" },
    { "<leader>fh" , builtin.help_tags, mode="n", desc = "Help Tags" },
    { "<leader>fs" , builtin.treesitter, mode="n", desc = "Treesitter" },
    { "<leader>fvb" , builtin.git_branches, mode="n", desc = "Git Branches" },
    { "<leader>fvs" , builtin.git_status, mode="n", desc = "Git Status" },
    { "<leader>fvx" , builtin.git_stash, mode="n", desc="Git Stash" },
    { "<leader>k" , builtin.grep_string, mode="n", desc="Grep string under the cursor" }
}

local setup = function()
  require('telescope').setup{
    defaults = {
      layout_strategy = 'vertical',
      -- layout_config = { height = 0.95 },
    },
  }
end

local lazy = function()
    return {
        "telescope.nvim",
        keys = keys,
        after = setup,
    }
end

return {
    lazy = lazy,
}
