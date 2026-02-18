{ ... }:
{
  programs.waybar = {
    enable = true;
    # systemd.enable = true;
    style = (builtins.readFile ./waybar.css);
    settings.mainBar = {
      height = 46;
      # margin-top = 10;
      # margin-bottom = 0;
      # margin-left = 10;
      # margin-right = 10;
      spacing = 10;

      modules-left = [ "custom/nix" "hyprland/window" ];
      modules-center = [ "hyprland/workspaces" ];
      modules-right = [ "tray" "cpu" "memory" "hyprland/language" "clock" ];

      #m-
      "hyprland/language" = {
        format-hu = " hu";
        format-no = " nb";
      };
      "hyprland/window" = {
        format = " {title}  "; # half width space lol
      };
      "clock" = {
        format = "{:%Y-%m-%d %H:%M}";
      };
      "memory" = {
        format = " {used:0.1f}  {swapUsed:0.1f}"; # {used:0.1f}/{total:0.0f} - {swapUsed:0.1f}/{swapTotal:0.0f}
        # format = "{percentage}%";
        interval = 1;
      };
      cpu = {
        interval = 1;
        format = " {usage}% {max_frequency:0.1f}GHz";
      };
      tray = {
        icon-size = 22;
        spacing = 6;
      };
      "custom/nix" = {
        exec = "echo '<img src=\"/home/vw222/.config/nix.png\"/>'";
        interval = 0;
        format = "{}";
        tooltip = false;
      };
    };
  };
}
