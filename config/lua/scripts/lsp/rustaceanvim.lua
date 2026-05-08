vim.g.rustaceanvim = {
    server = {
        default_settings = {
            ["rust-analyzer"] = {
                checkOnSave = false,
                cargo = {
                    allFeatures = true,
                },
            },
        },
    },
}
