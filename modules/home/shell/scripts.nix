{config, lib, pkgs, ...}: {
  home-manager.users."jackson" = {
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
      pkgs.mpd
      pkgs.mpc-cli
    ];

    home.file.".scripts" = {
      source = ./.scripts;
      recursive = true;
    };

    home.sessionPath = [
      "$HOME/.scripts"
    ];
  };
}

