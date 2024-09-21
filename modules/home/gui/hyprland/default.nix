{config, pkgs, lib, ...}: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  hardware = {
    opengl.enable = true;
  };

  home.file.".config/hypr" = {
    source = ./hypr;
    recursive = true;
  };
}
