local setup = function()
    local bufferline = require("bufferline")
    bufferline.setup({
        options = {
            show_close_icon = false,
            show_buffer_close_icons = false,
            show_buffer_icons = false,
            indicator = {
                style = 'none'
            },
            offsets = {
                separator = false
            },
            seperator_style = 'thin'
        },
    })
end

local lazy = function()
    return {
        "bufferline.nvim",
        after = setup,
    }
end

return {
    lazy = lazy,
}
