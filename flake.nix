{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    vim-buftabline-src = {
      url = "github:ap/vim-buftabline";
      flake = false;
    };
    flake-utils.url = "github:numtide/flake-utils";
    neovim-flake.url = "github:jordanisaacs/neovim-flake";
    neovim-flake.inputs.flake-utils.follows = "flake-utils";
    neovim-flake.inputs.nixpkgs.follows = "nixpkgs";
    noctu = {
      url = "github:noahfrederick/vim-noctu";
      flake = false;
    };
  };

  outputs = {
    nixpkgs,
    neovim-flake,
    vim-buftabline-src,
    flake-utils,
    noctu,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (system: let
      vim-buftabline = pkgs.vimUtils.buildVimPlugin {
        name = "vim-buftabline";
        src = vim-buftabline-src;
      };
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
        ];
      };
      lib = nixpkgs.lib;
      nvimlib = neovim-flake.lib.nvim;
      configModule = {
        config = {
          build.rawPlugins = nvimlib.plugins.fromInputs inputs "plugin-";
          vim = lib.mkMerge [
            {
              chatgpt.enable = false;
              theme.enable = lib.mkForce false;
              theme.name = "gruvbox";
              languages.nix.enable = true;
              filetree.nvimTreeLua.enable = false;
              tabline.nvimBufferline.enable = true;
              autopairs.enable = false;
              autoIndent = true;
              languages = {
                sql.lsp.enable = false;
              };
              lsp = {
                formatOnSave = true;
              };
              treesitter.grammars = [
                pkgs.vimPlugins.nvim-treesitter-parsers.php
              ];
              preventJunkFiles = true;
              startPlugins = with pkgs.vimPlugins; [
                hop-nvim
                ranger-vim
                kommentary
                telescope-fzf-native-nvim
                fzf-vim
                haskell-tools-nvim
                nvim-dap
                nvim-surround
                guess-indent-nvim
                nvim-ts-context-commentstring
                symbols-outline-nvim
                idris-vim
                base16-nvim
                fugitive
                ultisnips
                vimwiki
                fzf-hoogle-vim
                vim-dispatch
                vim-dispatch-neovim
              ];
              nnoremap = {
                "-" = ":bp<CR>";
                "=" = ":bn<CR>";
                "<C-d>" = ":w<CR>";
                "F" = ":RangerCurrentFile<CR>";
                "<leader>k" = "\"zyiw :Rg <C-r>z<CR>";
                "<C-p>" = "<Esc>:Rg ";
                "<leader>G" = "<cmd> Telescope git_files<CR>";
                "<leader>L" = "<cmd> Lines<CR>";
                "c/" = ":nohlsearch<CR>";
                "<F4>" = ":SymbolsOutline<CR>";
                "<leader>ad" = "<cmd>let g:formatsave=v:false<CR>";
                "<leader>ae" = "<cmd>let g:formatsave=v:true<CR>";
                "<leader>ww" = "<cmd>VimwikiIndex<CR>";
              };
              inoremap = {
                "<C-k>" = "<Esc>";
                "<C-d>" = "<Esc>:w<CR>";
              };
              luaConfigRC = {
                myHop = nvimlib.dag.entryAfter ["hop"] ''
                  local hop = require('hop')
                  hop.setup()
                  vim.keymap.set("", '<c-l>', function()
                    hop.hint_words()
                  end, {remap=true})
                '';
                bufferline = nvimlib.dag.entryAfter ["nvimBufferline"] ''
                  require('bufferline').setup({
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
                    }
                  })
                '';
                hoverForDiagnostics = nvimlib.dag.entryAnywhere ''
                  vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]]
                '';
                surround = nvimlib.dag.entryAnywhere ''
                  require("nvim-surround").setup({})
                '';
                treesitterCommentContext = nvimlib.dag.entryAnywhere ''
                  require('nvim-treesitter.configs').setup {
                    ensure_installed = {},
                    auto_install = false,
                    context_commentstring = {
                      enable = true,
                    },
                  }
                '';
                guessIndent = nvimlib.dag.entryAnywhere ''
                  require('guess-indent').setup {}
                '';
                treeSitterIndent = nvimlib.dag.entryAnywhere ''
                  require'nvim-treesitter.configs'.setup {
                    indent = {
                      enable = true
                    }
                  }
                '';
                symbolsOutline = nvimlib.dag.entryAnywhere ''
                  require("symbols-outline").setup()
                '';
                telescopeFzf = nvimlib.dag.entryAfter ["telescope"] ''
                  require('telescope').setup {
                    extensions = {
                      fzf = {
                        fuzzy = true,                    -- false will only do exact matching
                        override_generic_sorter = true,  -- override the generic sorter
                        override_file_sorter = true,     -- override the file sorter
                        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                                         -- the default case_mode is "smart_case"
                      }
                    }
                  }
                  require('telescope').load_extension('fzf')
                '';
                haskellToolsConfiguration = ''
                  lspconfig.hls.setup {
                    capabilities = capabilities;
                    on_attach = function (client, bufnr, ht)
                      local opts = { noremap = true, silent = true, buffer = bufnr, }
                      local ht = require('haskell-tools')
                      vim.keymap.set('n', '<space>hs', ht.hoogle.hoogle_signature, opts)
                    end,
                    cmd = { "haskell-language-server-wrapper", "--lsp", "-j", "2" };
                    root_dir = lspconfig.util.root_pattern("hie.yaml", "stack.yaml", ".cabal", "cabal.project", "project.yaml");
                  };

                  -- vim.g.haskell_tools = {
                  --   tools = {
                  --      hover = {
                  --       stylize_markdown = false,
                  --       auto_focus = true,
                  --     },
                  --   },
                  --   hls = {
                  --     on_attach = function (client, bufnr, ht)
                  --       local opts = { noremap = true, silent = true, buffer = bufnr, }
                  --       vim.keymap.set('n', '<space>hs', ht.hoogle.hoogle_signature, opts)
                  --     end,
                  --   },
                  --   cmd = { "haskell-language-server-wrapper", "--lsp", "-j", "2" };
                  --   root_dir = lspconfig.util.root_pattern("hie.yaml", "stack.yaml", ".cabal", "cabal.project", "project.yaml");
                  -- }
                '';
                treesitterWarningFix = nvimlib.dag.entryAnywhere ''
                  require('ts_context_commentstring').setup {}
                  vim.g.skip_ts_context_commentstring_module = true
                '';
              };
              configRC = {
                lineNumbers = nvimlib.dag.entryAnywhere ''
                  set norelativenumber
                '';
                /*
                   noctuTheme = nvimlib.dag.entryAfter ["lineNumbers"] (builtins.readFile "${noctu}/colors/noctu.vim");
                force16Clors = nvimlib.dag.entryAfter ["noctuTheme"] ''
                  set notermguicolors t_Co=16
                '';
                */
                ai = nvimlib.dag.entryAnywhere ''
                  let g:copilot_no_tab_map = v:true
                  imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
                  let g:copilot_no_tab_map = v:true
                '';
                hoogle = nvimlib.dag.entryAnywhere ''
                  let g:hoogle_fzf_cache_file = '~/.hoogle_cache.json'
                '';
                direnv = nvimlib.dag.entryAfter ["luaScript"] ''
                  if filereadable($DIRENV_EXTRA_VIMRC)
                    source $DIRENV_EXTRA_VIMRC
                  endif
                '';
                whitespace = nvimlib.dag.entryAnywhere ''
                  function <SID>StripTrailingWhitespace()
                      " Preparation: save last search, and cursor position.
                      let l:_s=@/
                      let l:l = line('.')
                      let l:c = col('.')
                      " Do the business:
                      %s/\s\+$//e
                      " Clean up: restore previous search history, and cursor position
                      let @/=l:_s
                      call cursor(l:l, l:c)
                  endfunction
                  nmap <silent> <leader>t :call <SID>StripTrailingWhitespace()<CR>
                '';
                ultisnips = nvimlib.dag.entryAnywhere ''
                  let g:UltiSnipsExpandTrigger='<c-a>'
                  let g:UltiSnipsJumpForwardTrigger='<c-l>'
                  let g:UltiSnipsJumpBackwardTrigger='<c-h>'
                  let g:UltiSnipsSnippetDirectories = ["UltiSnips", "${./snippets}"]
                '';
              };
            }
          ];
        };
      };
      vimColors = cfg: {
        config.vim = {
          startPlugins = with pkgs.vimPlugins; [
            base16-nvim
          ];
          luaConfigRC = {
            base16-colors =
              if builtins.hasAttr "colorscheme" cfg
              then
                (nvimlib.dag.entryAnywhere ''
                  vim.cmd('colorscheme ${cfg.colorscheme}')
                '')
              else if builtins.hasAttr "colorPallet" cfg
              then ''
                require('base16-colorscheme').setup({
                  base00 = '#${cfg.colorPallet.base01}', base01 = '#${cfg.colorPallet.base01}', base02 = '#${cfg.colorPallet.base02}', base03 = '#${cfg.colorPallet.base03}',
                  base04 = '#${cfg.colorPallet.base04}', base05 = '#${cfg.colorPallet.base05}', base06 = '#${cfg.colorPallet.base06}', base07 = '#${cfg.colorPallet.base07}',
                  base08 = '#${cfg.colorPallet.base08}', base09 = '#${cfg.colorPallet.base09}', base0A = '#${cfg.colorPallet.base0A}', base0B = '#${cfg.colorPallet.base0B}',
                  base0C = '#${cfg.colorPallet.base0C}', base0D = '#${cfg.colorPallet.base0D}', base0E = '#${cfg.colorPallet.base0E}', base0F = '#${cfg.colorPallet.base0F}',
                })
              ''
              else ''
                vim.cmd('colorscheme default')
              '';
            base16-comment-override =
              nvimlib.dag.entryAfter ["base16-colors"]
              ''
                local color = require('base16-colorscheme').colors.base04
                vim.cmd('highlight Comment guifg=' .. color)
                vim.cmd('highlight TSComment guifg=' .. color)
              '';
            buftabLineHighlighting = nvimlib.dag.entryAnywhere ''
              local colors = require('base16-colorscheme').colors
              vim.cmd('hi clear BufTabLineCurrent')
              vim.cmd('hi clear BufTabLineActive')
              vim.cmd('hi clear ColorColumn')
              vim.cmd('hi BufTabLineHidden guibg=' .. colors.base00 .. ' ctermfg=214 ctermbg=237 guifg=' .. colors.base0B)
              vim.cmd('hi BufTabLineActive guibg=' .. colors.base01 .. ' ctermfg=214 ctermbg=237 guifg=' .. colors.base07)
              vim.cmd('hi BufTabLineCurrent guibg=' .. colors.base02 .. ' ctermfg=214 ctermbg=237 gui=bold cterm=bold guifg=' .. colors.base07)
              vim.cmd('hi BufTabLineFill guibg=' .. colors.base00 .. ' ctermfg=214 ctermbg=237 guifg=' .. colors.base0B)
              vim.cmd('hi clear BufferLineBufferSelected')
              vim.cmd('hi clear BufferLineBufferVisible')
              vim.cmd('hi BufferLineBufferSelected guibg=' .. colors.base02 .. ' ctermfg=214 ctermbg=237 gui=bold cterm=bold guifg=' .. colors.base07)
              vim.cmd('hi BufferLineBufferVisible guibg=' ..colors.base01 .. ' ctermfg=214 ctermbg=237 guifg=' .. colors.base07)
            '';
          };
        };
      };

      baseNeovim = neovim-flake.packages.${system}.maximal;
      neovimExtended = baseNeovim.extendConfiguration {
        modules = [configModule];
      };
      anotherExtension = neovimExtended.extendConfiguration {
        inherit pkgs;
        modules = [
          configModule
          (vimColors {
            colorscheme = "base16-gruvbox-material-dark-hard";
            colorPallet = {
              base00 = "111111"; # black
              base01 = "2a2a26";
              base02 = "555555";
              base03 = "777777";
              base04 = "999999";
              base05 = "f0b2bc"; # used for parens and other tokens
              base06 = "dddddd";
              base07 = "f0b2bc"; # white
              base08 = "dc3d3b"; # red
              base09 = "ff7500"; # orange
              base0A = "faefe1"; # yellow
              base0B = "a6e165"; # green
              base0C = "8bc7c3"; # aqua
              base0D = "1d75b7"; # blue
              base0E = "a46dc8"; # purple
              base0F = "2184cf"; # maroon
            };
          })
        ];
      };
    in {
      packages = rec {
        neovim = anotherExtension;
        default = neovim;
        colorless = neovimExtended.extendConfiguration {
          inherit pkgs;
          modules = [configModule];
        };
      };
      lib = {
        baseModule = configModule;
        inherit vimColors;
      };
    });
}
