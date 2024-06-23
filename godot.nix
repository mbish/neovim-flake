{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.languages.gdscript;

  defaultServer = "gdscript";
  servers = {
    gdscript = {
      package = ["gdscript"];
      lspConfig = ''
        lspconfig.gdscript.setup {}
      '';
    };
  };
in {
  options.vim.languages.gdscript = {
    enable = mkEnableOption "Godot Script support";

    treesitter = {
      enable = mkOption {
        description = "Enable Godot treesitter";
        type = types.bool;
        default = config.vim.languages.enableTreesitter;
      };
      package = nvim.options.mkGrammarOption pkgs "gdscript";
    };

    lsp = {
      enable = mkOption {
        description = "Enable GDScript LSP support";
        type = types.bool;
        default = config.vim.languages.enableLSP;
      };
      server = mkOption {
        description = "GDScript LSP server to use";
        type = with types; enum (attrNames servers);
        default = defaultServer;
      };
      package = nvim.options.mkCommandOption pkgs {
        description = "GDScript LSP server";
        inherit (servers.${cfg.lsp.server}) package;
      };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    (mkIf cfg.treesitter.enable {
      vim.treesitter.enable = true;
      vim.treesitter.grammars = [cfg.treesitter.package];
    })

    (mkIf cfg.lsp.enable {
      vim.lsp.lspconfig.enable = true;
      vim.lsp.lspconfig.sources.gdscript-lsp = servers.${cfg.lsp.server}.lspConfig;
    })
  ]);
}
