{config, lib, pkgs, ...}: {
  home.packages = [
    pkgs.libnotify
  ];
}
