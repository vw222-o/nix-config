{
  pkgs,
  ...
}:

#let
#  nixvim = import ./nixvim {};
#in
{
  home.username = "vw222";
  home.homeDirectory = "/home/vw222";
  # https://nixos-and-flakes.thiscute.world/nixos-with-flakes/start-using-home-manager

  imports = [
    ./desktop
    ./programs
    ./plasma.nix
  ];

  home.packages = with pkgs; [
    #    inputs.nixvim

    #nmap
    btop
    #iftop

    mangohud

    vesktop
    vivaldi
    prismlauncher
    fastfetch
    vlc
    keypunch # fun

    #server stuff
    putty
    #docker -- the fucking daemon in config only

    vscode
    gparted

    tree
    cowsay
    sl
    cmatrix
    nyancat
    nix-output-monitor

    gemini-cli # god i hate this

    #mako # figure stuffs out later
    #lsfg-vk-ui

    nordic
    libsForQt5.qt5ct
    kdePackages.qt6ct
    #nwg-look

    libappindicator

    nerd-fonts.fira-code
  ];

  fonts.fontconfig.enable = true;

  catppuccin = {
    enable = false;
    flavor = "macchiato";
  };

  home.file.".config/nix.png".source = pkgs.fetchurl {
    url = "https://discourse.nixos.org/uploads/default/original/3X/9/b/9b822d84faa0f11626c6d72ca9a24d7b89e793be.png";
    sha256 = "JBNR8CXZuaOM1BMudYeNQIElCMep0G5ps8Gx1nUcYI0=";
  };

  programs.hyprshot = {
    enable = true;
    saveLocation = "$HOME/Pictures/Screenshots";
  };
  programs.distrobox = {
    enable = true;
  };
  services.podman = {
    enable = true;
  };
  services.activitywatch = {
    enable = true;
  };
  programs.swappy = {
    enable = true;
    settings = {
      Default = {
        early_exit = true;
      };
    };
  };

  services.nextcloud-client.enable = true;

#  services.mako.enable = true;   #reenable for hyprland
  services.hyprpolkitagent.enable = true;
  services.hyprsunset.enable = true;
#  services.hypridle.enable = true;

  services.owncloud-client.enable = false;
  services.flameshot.enable = true;
  services.flameshot.settings = {
    General = {
      useGrimAdapter = true;
    };
  };

  #xdg.configFile."~/.gtkrc-2.0".force = true;
  xdg.configFile."flameshot/flameshot.ini".force = true;
#  home-manager.backupFileExtension = "hm.OLD";

  programs.vicinae = {
    enable = true;
    systemd = {
      autoStart = true;
      enable = true;
    };
  };

  programs.obs-studio.enable = true;
  programs.anki.enable = true;
  programs.zed-editor.enable = true;

  home.stateVersion = "25.05";
}
