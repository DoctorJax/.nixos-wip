# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # Home Manager
      inputs.home-manager.nixosModules.default

      # Modules
      ../../modules/home/gui/default.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Cinnamon Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.cinnamon.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jackson = {
    isNormalUser = true;
    description = "jackson";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    ignoreShellProgramCheck = true;
  }; 

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    users."jackson" = {
      # Home Manager needs a bit of information about you and the paths it should
      # manage.
      home.username = "jackson";
      home.homeDirectory = "/home/jackson";
      xdg.enable = true;
    
      # TLDR: Don't change this unless you know what you're doing.
      home.stateVersion = "24.05";
    
      imports = [
        # Modules
        ../../modules/home/shell/default.nix
      ];
    
      home.sessionVariables = {
        EDITOR = "vim";
      };
    
      # Let Home Manager install and manage itself.
      programs.home-manager.enable = true;
    };
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Fix dynamic libraries missing compared to standard distros.
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      # add missing dynamic libraries here
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    pulseaudio
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  # TLDR: Only change this if you wanna break shit unless you read the
  # documentation for it. Perfectly safe to leave it the original value.
  system.stateVersion = "24.05";
}
