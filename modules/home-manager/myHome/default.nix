{
  imports = [
    ./cli.nix
    ./neovim
    ./tmux.nix
    ./zsh
  ];

  myHome = {
    neovim = {
      enable = true;
      enableLSP = true;
    };
    zsh.enable = true;

  };
}
