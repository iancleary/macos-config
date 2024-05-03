# list recipes
help:
  just --list

# Initial Setup Step 1
step1-setup:
  mkdir -p ~/.config/nix-darwin
  cd ~/.config/nix-darwin
  nix flake init -t nix-darwin
  sed -i '' "s/simple/$(scutil --get LocalHostName)/" flake.nix

# Initial Setup Step 2
step2-install:
  nix run nix-darwin -- switch --flake '.?submodules=1'

# Initial Setup Step 3
step3-switch:
  git submodule update --init --recursive
  darwin-rebuild switch --flake '.?submodules=1'

# Apply changes to system per flake
switch:
  git submodule update --init --recursive
  darwin-rebuild switch --flake '.?submodules=1'

# Update flake
update:
  nix flake update
