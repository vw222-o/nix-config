# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./init.nix
    ./users.nix
    #./cosmic.nix
  ];

  programs.dconf.enable = true;

  hardware.amdgpu.opencl.enable = true;
  hardware.amdgpu.initrd.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  time.timeZone = "Europe/Budapest";
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "hu_HU.UTF-8";
    LC_IDENTIFICATION = "hu_HU.UTF-8";
    LC_MEASUREMENT = "hu_HU.UTF-8";
    LC_MONETARY = "hu_HU.UTF-8";
    LC_NAME = "hu_HU.UTF-8";
    LC_NUMERIC = "hu_HU.UTF-8";
    LC_PAPER = "hu_HU.UTF-8";
    LC_TELEPHONE = "hu_HU.UTF-8";
    LC_TIME = "hu_HU.UTF-8";
  };

  services.xserver.enable = false; # xwayland stuff
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "hu";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "hu";

  # Enable CUPS to print documents.
  services.printing.enable = false;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;
  security.pam.services.login.enableGnomeKeyring = true;
  security.polkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Install firefox.
  programs.firefox.enable = false;

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    vivaldi = {
      proprietaryCodecs = true;
      enableWideVine = true;
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget

    pulseaudio
    ntfs3g # very importante lol
    #pkgs.fishPlugins.sdkman-for-fish
    wl-clipboard

    cifs-utils

    # dev
    nixfmt
    nixd

    screen

    vivaldi-ffmpeg-codecs
    ffmpeg

    unzip
    unrar
    p7zip
    wget
    pkgs.zip
    #     jdk25_headless
    graalvmPackages.graalvm-ce
    tmux
    git

    mission-center

    heroic
    nordic
    #lutris
    xdg-utils

#    dotnetCorePackages.runtime_10_0-bin
    dotnetCorePackages.sdk_8_0-bin

    python314
    devenv
    direnv

    kdePackages.dolphin
    kdePackages.qtsvg
    kdePackages.kio
    kdePackages.kio-extras
    kdePackages.kio-fuse

    #jetbrains.rust-rover
    #bun
    jq

    lact

    #pkg-config
    #glib
  ];

  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3434", ATTRS{idProduct}=="0b10", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
  '';
  #users.users.vw222.extraGroups = ["input"];

  programs.gamemode.enable = true;
  services.zerotierone.enable = true;

  environment.sessionVariables = {
#    QT_QPA_PLATFORMTHEME = "qt6ct";
  };

  programs.appimage = {
    enable = true;
    binfmt = true;
  };
  programs.nix-ld.enable = true;

  system.userActivationScripts = {
    removeConflictingFiles = {
      text = ''
        rm -f /home/vw222/.gtkrc-2.0
      '';
    };
  };

  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-macchiato.yaml";
  stylix.fonts = {
    serif = {
      package = pkgs.nerd-fonts.fira-code;
      name = "FiraCode Nerd Font";
    };

    sansSerif = {
      package = pkgs.nerd-fonts.fira-code;
      name = "FiraCode Nerd Font";
    };

    monospace = {
      package = pkgs.nerd-fonts.fira-code;
      name = "FiraCode Nerd Font Mono";
    };

    emoji = {
      package = pkgs.noto-fonts-color-emoji;
      name = "Noto Color Emoji";
    };
  };


      #putty
  virtualisation.docker.enable = true;

  programs.steam.enable = true;
  programs.fish.enable = true;
  programs.fish.shellAbbrs = {
    update = "sudo nixos-rebuild switch --upgrade &| nom";
    deb-run = "distrobox-enter Debian --";
  };
  programs.fish.interactiveShellInit = ''
    set fish_greeting # Disable greeting
  '';
  users.users.vw222.shell = pkgs.fish;
  programs.hyprland.enable = true;

  services.flatpak.enable = true;

  services.flatpak.packages = [
    "org.vinegarhq.Sober"
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
