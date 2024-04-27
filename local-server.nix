{
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.server;
in {
  options.vim.server = {
    enable = mkEnableOption "Enable nvim server";
  };

  config = mkIf cfg.enable {
    vim.luaConfigRC.nvimServer = ''
      local pipepath = vim.fn.stdpath("cache") .. "/server.pipe"
      if not vim.loop.fs_stat(pipepath) then
        vim.fn.serverstart(pipepath)
      end
    '';
  };
}
