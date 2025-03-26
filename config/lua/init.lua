-- 1. base configuration
require("scripts.settings")
require("scripts.keys")

-- 2. non-lazy plugins configs
require("scripts.direnv")
require("scripts.ranger")
require("scripts.treesitter")
require("scripts.vimwiki")
require("scripts.which-key")

-- 3. lazy configs and tweaks
require("scripts.lz-n")
