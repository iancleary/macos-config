{ config, pkgs, ... }: 

{
  # https://github.com/nix-community/nix-direnv
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
}
