{ inputs, config, pkgs, ... }:

{
  programs.nixvim = {
    enable = true;

    plugins = {
      lightline.enable = true;
      neo-tree.enable = true;
      rustaceanvim.enable = true;
    };

    # https://neovim.io/doc/user/options.html
    options = {
      number = true;         # Show line numbers
      relativenumber = false; # Show relative line numbers
      shiftwidth = 2;        # Tab width should be 2
    };
  };
}
