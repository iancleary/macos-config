{ pkgs, self, ... }: 

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget

  # https://github.com/nix-community/nix-direnv
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
    
  environment.systemPackages = with pkgs;
    [ 
      just
      graphite-cli

      # VS Code (for extensions)
      nodejs_18

      # For terminal output with chezmoi dotfiles...merging over to this config
      colorls

      # while migrating dotfiles
      chezmoi
    ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina
  # programs.fish.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}