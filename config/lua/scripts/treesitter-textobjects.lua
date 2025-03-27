local setup = function ()
    local ts = require("nvim-treesitter.configs")
    ts.setup({
        textobjects
    })
end
