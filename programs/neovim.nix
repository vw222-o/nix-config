{pkgs, ...}:

{
  programs.neovim = {
    enable = true;
    extraConfig = ''
      set number
    '';
    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim
    ];
  };

  /*
  colorschemes.catppuccin = {
    enable = true;
    autoLoad = true;
    settings = {
      flavor = "macchiato";
    };
  };
  clipboard = {
    providers = {
      wl-copy.enable = true; # For Wayland
    };

    register = "unnamedplus";
  };
  opts.number = true;
  opts.clipboard = "unnamedplus";*/
}
