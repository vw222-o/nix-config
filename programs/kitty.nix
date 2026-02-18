{ lib, ... }:
{
  programs.kitty = {
    enable = true;
    font = {
#      name = "FiraCode Nerd Font";
# already specified in stylix
      size = lib.mkForce 16; # stylix wants to override
    };
    extraConfig = ''
      clipboard_control write-clipboard write-primary
    '';
  };
}
