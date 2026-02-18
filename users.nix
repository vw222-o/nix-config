{
  pkgs,
  lib,
  ...
}: 

{
  users.users.vw222 = {
    isNormalUser = true;
    description = "VW222";
    extraGroups = [
      "networkmanager"
      "wheel"
      "input"
    ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };
}
