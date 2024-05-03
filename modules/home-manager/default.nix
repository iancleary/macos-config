{ inputs, lib, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = rec {
    username = "iancleary";
    homeDirectory = lib.mkForce "/Users/${username}"; # lib.mkForce allows for user to already exist
    stateVersion = lib.mkDefault "23.11";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Rest of the configuration is in a separate folder.
  imports = [
    inputs.terminal-config.homeManagerModules.default
  ];
}
