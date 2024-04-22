{
  default = { config, lib, ... }: {
    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    home = rec {
      username = "iancleary";
      homeDirectory = lib.mkForce "/Users/${username}"; # lib.mkForce allows for user to already exist
      stateVersion = lib.mkDefault "23.11";
    };
  };
  myHome = import ./myHome;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
