local leap = require("leap")
leap.opts.safe_labels = ""
leap.opts.equivalence_classes = { " \t\r\n", "aA", "bB", "cC", "dD", "eE", "fF", "gG", "hH", "iI", "jJ", "kK", "lL", "mM", "nN", "oO", "pP", "qQ", "rR", "sS", "tT", "uU", "vV", "wW", "xX", "yY", "zZ" }
vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
