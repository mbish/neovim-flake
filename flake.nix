{
  description = "Neovim with LSP and lazy-loading";
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs =
    {
      nixpkgs,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
          ];
          config.allowUnfree = true;
        };
        customRC = import ./config { inherit pkgs; };
        neovimWrapped = pkgs.wrapNeovim pkgs.neovim-unwrapped {
          configure = {
            inherit customRC;
            packages.myVimPackage = with pkgs.vimPlugins; {
              start = [
                base16-nvim
                copilot-vim
                fzf-vim
                nvim-lspconfig
                vim-sleuth
                gitsigns-nvim
                cmp-nvim-lsp
                cmp-path
                cmp-nvim-lsp-signature-help
                guess-indent-nvim
                haskell-tools-nvim
                hop-nvim
                nvim-cmp
                idris-vim
                kommentary
                lz-n
                nvim-treesitter-textobjects
                nvim-treesitter.withAllGrammars
                nvim-ts-context-commentstring
                ranger-vim
                telescope-fzf-native-nvim
                ultisnips
                ultisnips
                vim-dispatch
                vim-dispatch-neovim
                vim-swap
                vimwiki
                which-key-nvim
                cyberdream-nvim
              ];
              opt = [
                gitsigns-nvim
                vim-startuptime
                telescope-nvim
                symbols-outline-nvim
                nvim-lint
                conform-nvim
                nvim-surround
                fugitive
                vim-markdown
                markdown-preview-nvim
                vim-suda
                luvit-meta
                lazydev-nvim
                lualine-nvim
                bufferline-nvim
                nvim-dap
              ];
            };
          };
        };
        app = pkgs.writeShellApplication {
          name = "nvim";
          text = ''
            exec ${neovimWrapped}/bin/nvim "$@"
          '';
          runtimeInputs =
            with pkgs;
            [
              # file utilities
              git
              ranger

              # telescope and treesitter dependencies
              ripgrep
              fd
              fzf
              powerline-fonts
              gcc

              # always install lua and nix lsp
              nixd
              lua-language-server
              lua54Packages.luacheck
              shellcheck
              stylua
              nixfmt-rfc-style
              yamlfix
              yamllint
            ]
            ++ vimPlugins.nvim-treesitter.withAllGrammars.dependencies;
        };
      in
      {
        packages = {
          default = app;
        };
        apps = {
          default = {
            type = "app";
            program = "${app}/bin/nvim";
          };
        };
      }
    );
}
