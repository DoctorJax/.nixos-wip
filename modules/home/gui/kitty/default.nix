{config, pkgs, lib, ...}: {
  home-manager.users."jackson" = {
    programs.kitty.enable = true;

    home.file.".config/kitty" = {
      source = ./kitty;
      recursive = true;
    };
  };
}
