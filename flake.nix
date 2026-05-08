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
        nvim-treesitter-custom-grammars = (
          pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
            p.lua
            p.nix
            p.rust
            p.haskell
            p.python
            p.javascript
            p.typescript
            p.html
            p.css
            p.json
            p.yaml
            p.toml
            p.bash
            p.markdown
          ])
        );
        customRC = import ./config {
          inherit pkgs;
        };
        neovimWrapped = pkgs.wrapNeovim pkgs.neovim-unwrapped {
          withPython3 = true;
          extraPythonPackages = ps: [ ps.pynvim ];
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
                guess-indent-nvim
                haskell-tools-nvim
                idris-vim
                leap-nvim
                lz-n
                nvim-cmp
                nvim-lspconfig
                nvim-treesitter-context
                nvim-treesitter-custom-grammars
                nvim-treesitter-textobjects
                nvim-ts-autotag
                nvim-ts-context-commentstring
                ranger-vim
                rustaceanvim
                telescope-fzf-native-nvim
                ultisnips
                vim-dispatch
                vim-dispatch-neovim
                vim-rhubarb
                vim-sleuth
                vim-swap
                vim-test
                which-key-nvim
              ];
              opt = [
                bufferline-nvim
                conform-nvim
                vim-fugitive
                gitsigns-nvim
                kommentary
                lazydev-nvim
                lualine-nvim
                luvit-meta
                markdown-preview-nvim
                nvim-dap
                nvim-lint
                nvim-surround
                outline-nvim
                telescope-nvim
                vim-markdown
                vim-startuptime
                vim-suda
                vimwiki
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

              # always install lua and nix lsp
              nixd
              lua-language-server
              lua54Packages.luacheck
              shellcheck
              stylua
              nixfmt
              yamlfix
              yamllint
              prettier
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
        overlays = {
          default = final: prev: {
            neovim = app;
          };
          minimal = final: prev: {
            neovim = minimalNeovim;
          };
        };
      }
    );
}
