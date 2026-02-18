{...}: 

{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
#        after_sleep_cmd = "hyprctl dispatch dpms on";
#        ignore_dbus_inhibit = false;
        lock_cmd = "pidof hyprlock || hyprlock";
	inhibit_sleep = 3;
      };

      listener = [
        {
          timeout = 120;
          on-timeout = "systemctl suspend";
        }
#        {
#          timeout = 1200;
#          on-timeout = "hyprctl dispatch dpms off";
#          on-resume = "hyprctl dispatch dpms on";
#        }
      ];
    };
  };
}
