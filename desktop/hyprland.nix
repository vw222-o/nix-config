{ pkgs, lib, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = ", preferred, auto, 1.25";
      env = [
        "GDK_SCALE,1.25"
      ];

      input = {
        kb_layout = "hu,no";
        kb_options = "compose:rwin";
	accel_profile = "flat";
        sensitivity = -0.35;
      };

      general = {
        border_size = 5;

        gaps_out = 10;
        gaps_in = 8;
        resize_on_border = true;
        "col.active_border" = lib.mkForce "rgba(ff1414d7) rgba(57ff14d7) 45deg";
      };

      decoration = {
        inactive_opacity = 0.8;
        blur.enabled = true;
        blur.size = 3;
        layerrule = [
          "blur,waybar"
          "blur,vicinae"
        ];
      };

      misc = {
        disable_hyprland_logo = true;
      };

      bezier = [
        "CUM, 0.645, 0.045, 0.355, 1"
      ];

      animation = [
        "workspaces, 1, 6, CUM, slidevert"
      ];

      "$mod" = "ALT";

      bind = [
        ", XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +2db"
        ", XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -2db"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        "$mod, Q, killactive"
        "$mod, P, exec, vicinae toggle" # wofi --show drun
        "$mod, Return, exec, kitty"
        ", PRINT, exec, hyprshot -m region"
        "SUPER,T,fullscreen"
        "SUPER,I,exec, hyprlock"
      ]
      ++ (builtins.concatLists (
        builtins.genList (
          i:
          let
            ws = i + 1;
          in
          [
            "$mod, code:1${toString i}, workspace, ${toString ws}"
            "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]
        ) 9
      ));

      bindm = [
        # mouse movements
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];

      exec-once = [
        "waybar"
        "pactl set-sink-volume @DEFAULT_SINK@ 71% 75%"
        "${pkgs.kdePackages.kwallet-pam}/libexec/pam_kwallet_init"
        "systemctl --user start hyprpolkitagent"
        "kitty +kitten panel --edge=background -o background_opacity=0 cmatrix" # the funny
	"hyprsunset --temperature 3500"
	"hypridle"
      ];
      xwayland.force_zero_scaling = true;
    };
  };
}
