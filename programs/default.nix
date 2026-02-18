{ ... }:
{
  imports = [
    ./kitty.nix
    ./neovim.nix
    #./nixvim.nix
  ];
  #programs.nixvim.imports = [ ./nixvim.nix ];
}
