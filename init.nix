{
  pkgs,
  lib,
  ...
}: 

{
  boot.loader = {
    systemd-boot.enable = false;
    efi.canTouchEfiVariables = true;
  };
  boot.loader.limine = {
    enable = true;
    package = pkgs.limine;
  };

  boot.kernelPackages = pkgs.linuxPackages_testing;
  nix.settings.trusted-users = ["root" "vw222"];
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  services.greetd.enable = true;
  services.displayManager.sddm.enable = false;
  programs.regreet = {
    enable = true;
    settings = {
      GTK = {
        application_prefer_dark_theme = lib.mkForce true;
      };
    };
    font.size = 24;
  };
}
