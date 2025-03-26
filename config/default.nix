{pkgs}: let
  configDir = pkgs.stdenv.mkDerivation {
    name = "nvim-lua-lazy-configs";
    src = ./lua; # NOTE: the installPhase commands relative to this dir
    installPhase = ''
      mkdir -p $out/lua
      cp ./init.lua $out/
      cp -r ./scripts $out/lua/
    '';
  };
in ''
  set rtp+=${configDir}
  let g:snippet_path = "${../snippets}"
  source ${configDir}/init.lua
''
