{config, lib, pkgs, ...}: {
  home.packages = [
    pkgs.libnotify
  ];

  home.file.".scripts" = {
    source = ./.scripts;
    recursive = true;
  };

  home.sessionPath = [
    "$HOME/.scripts"
  ];
}

