{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "jackson";
  home.homeDirectory = "/home/jackson";

  # TLDR: Don't change this unless you know what you're doing.
  home.stateVersion = "24.05";

  imports = [
    # Modules
    ../../modules/home/shell.nix
  ];

  home.sessionVariables = {
    EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
