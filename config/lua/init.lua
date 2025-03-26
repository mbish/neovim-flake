-- 1. base configuration
require("scripts.settings")
require("scripts.keys")
require("scripts.whitespace")

-- 2. non-lazy plugins configs
require("scripts.cmp") -- can this be lazy?
require("scripts.copilot")
require("scripts.ranger")
require("scripts.treesitter")
require("scripts.vimwiki")
require("scripts.which-key")
require("scripts.ultisnips")

-- 3. lazy configs and tweaks
require("scripts.lz-n")

-- 4. local/project config
require("scripts.direnv")
