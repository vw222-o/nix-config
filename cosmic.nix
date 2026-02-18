{ ... }:
{
  services.desktopManager.cosmic.enable = false;
  services.system76-scheduler.enable = false;
  environment.sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;
}
