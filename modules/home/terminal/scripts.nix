{config, lib, pkgs, ...}: {
  home.packages = [
    pkgs.libnotify
    pkgs.headsetcontrol
    pkgs.alsa-utils
    pkgs.ffmpeg
    pkgs.grimblast
    pkgs.maim
    pkgs.ydotool
    pkgs.feh
    pkgs.swaybg
  ];

  home.file.".scripts" = {
    source = ./.scripts;
    recursive = true;
  };

  home.sessionPath = [
    "$HOME/.scripts"
  ];
}

