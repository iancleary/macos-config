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
  nix run nix-darwin -- switch --flake ~/.config/nix-darwin

# Initial Setup Step 3
step3-switch:
  darwin-rebuild switch --flake ~/.config/nix-darwin

# Apply changes to system per flake
switch:
  darwin-rebuild switch --flake ~/.config/nix-darwin

# Update flake
update:
  nix flake update
