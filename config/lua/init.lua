-- 1. base configuration
require("scripts.settings")
require("scripts.keys")
require("scripts.whitespace")

-- 2. non-lazy plugins configs
require("scripts.fzf") -- can this be lazy?
require("scripts.cmp") -- can this be lazy?
require("scripts.spelling") -- can this be lazy?
require("scripts.copilot")
require("scripts.ranger")
require("scripts.treesitter")
require("scripts.treesitter-textobjects")
require("scripts.treesitter-context")
require("scripts.vimwiki") -- we have to override these key mappings
require("scripts.which-key")
require("scripts.ultisnips")
require("scripts.gitsigns-all") -- can this be lazy?
require("scripts.leap")
require("scripts.test-vim")
-- require("scripts.lsp.rustaceanvim")

-- 3. lazy configs and tweaks
require("scripts.lz-n")

-- 4. local/project config
require("scripts.direnv")
