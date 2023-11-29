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
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      vim-buftabline = pkgs.vimUtils.buildVimPlugin {
        name = "vim-buftabline";
        src = vim-buftabline-src;
      };
      pkgs = nixpkgs.legacyPackages.${system};
      lib = nixpkgs.lib;
      nvimlib = neovim-flake.lib.nvim;
      configModule = {
        config.vim = {
          theme.enable = lib.mkForce true;
          theme.name = "gruvbox";
          languages.nix.enable = true;
          filetree.nvimTreeLua.enable = false;
          tabline.nvimBufferline.enable = true;
          autopairs.enable = false;
          lsp = {
            formatOnSave = true;
          };
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
            nvim-ts-context-commentstring
            symbols-outline-nvim
            idris-vim
            # copilot-vim
            # vim-buftabline
            fugitive
            ultisnips
          ];
          nnoremap = {
            "-" = ":bp<CR>";
            "=" = ":bn<CR>";
            "<C-d>" = ":w<CR>";
            "F" = ":RangerEdit<CR>";
            "<leader>k" = "\"zyiw :Rg <C-r>z<CR>";
            "<C-p>" = "<Esc>:Rg ";
            "<leader>G" = "<cmd> Telescope git_files<CR>";
            "<leader>L" = "<cmd> Lines<CR>";
            "c/" = ":nohlsearch<CR>";
            "<F4>" = ":SymbolsOutline<CR>";
            "<leader>ad" = "<cmd>let g:formatsave=v:false<CR>";
            "<leader>ae" = "<cmd>let g:formatsave=v:true<CR>";
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
              -- Haskell config
              lspconfig.hls.setup {
                capabilities = capabilities;
                on_attach = default_on_attach;
                cmd = { "haskell-language-server-wrapper", "--lsp", "-j", "2" };
                root_dir = lspconfig.util.root_pattern("hie.yaml", "stack.yaml", ".cabal", "cabal.project", "project.yaml");
              }
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
            buftabLineHighlighting = nvimlib.dag.entryAnywhere ''
              hi clear BufTabLineCurrent
              hi clear BufTabLineActive
              hi clear ColorColumn
              hi link BufTabLineCurrent GruvboxYellowSign
              hi BufTabLineHidden guibg=#282828 ctermfg=214 ctermbg=237 guifg=#a89984
              hi BufTabLineActive guibg=#3c3836 ctermfg=214 ctermbg=237 guifg=#fabd2f
              hi BufTabLineCurrent guibg=#504945 ctermfg=214 ctermbg=237 guifg=#fabd2f gui=bold cterm=bold
              hi BufTabLineFill guibg=#282828 ctermfg=214 ctermbg=237 guifg=#a89984
              hi link BufTabLineActive GruvboxYellow

              hi clear BufferLineBufferSelected
              hi clear BufferLineBufferVisible
              hi BufferLineBufferSelected guibg=#504945 ctermfg=214 ctermbg=237 guifg=#fabd2f gui=bold cterm=bold
              hi BufferLineBufferVisible guibg=#3c3836 ctermfg=214 ctermbg=237 guifg=#fabd2f
            '';
            ai = nvimlib.dag.entryAnywhere ''
              let g:copilot_no_tab_map = v:true
              imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
              let g:copilot_no_tab_map = v:true
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
        };
      };

      baseNeovim = neovim-flake.packages.${system}.maximal;
      neovimExtended = baseNeovim.extendConfiguration {
        inherit pkgs;
        modules = [configModule];
      };
    in {
      packages = rec {
        neovim = neovimExtended;
        default = neovim;
        other = neovim;
      };
    });
}
