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
                cmp-nvim-lsp
                cmp-nvim-lsp-signature-help
                cmp-nvim-ultisnips
                cmp-path
                copilot-vim
                crates-nvim
                cyberdream-nvim
                fzf-vim
                gitsigns-nvim
                guess-indent-nvim
                haskell-tools-nvim
                leap-nvim
                idris-vim
                kommentary
                lz-n
                nvim-cmp
                nvim-lspconfig
                rustaceanvim
                nvim-treesitter-context
                nvim-treesitter-textobjects
                nvim-treesitter.withAllGrammars
                nvim-ts-autotag
                nvim-ts-context-commentstring
                ranger-vim
                telescope-fzf-native-nvim
                ultisnips
                vim-dispatch
                vim-dispatch-neovim
                vim-sleuth
                vim-swap
                vim-rhubarb
                vimwiki
                which-key-nvim
                vim-test
              ];
              opt = [
                bufferline-nvim
                conform-nvim
                fugitive
                gitsigns-nvim
                lazydev-nvim
                lualine-nvim
                luvit-meta
                markdown-preview-nvim
                nvim-dap
                nvim-lint
                nvim-surround
                symbols-outline-nvim
                telescope-nvim
                vim-markdown
                vim-startuptime
                vim-suda
              ];
            };
          };
        };
        minimalNeovim = pkgs.wrapNeovim pkgs.neovim-unwrapped {
          configure = {
            inherit customRC;
            packages.myVimPackage = with pkgs.vimPlugins; {
              start = [
                leap-nvim
              ];
              opt = [
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
              nodePackages.prettier
            ]
            ++ vimPlugins.nvim-treesitter.withAllGrammars.dependencies;
        };
      in
      {
        packages = {
          default = app;
          minimal = minimalNeovim;
        };
        apps = {
          default = {
            type = "app";
            program = "${app}/bin/nvim";
          };
          minimal = {
            type = "app";
            program = "${minimalNeovim}/bin/nvim";
          };
        };
      }
    );
}
