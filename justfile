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
  nix run nix-darwin -- switch --flake .

# Initial Setup Step 3
step3-switch:
  darwin-rebuild switch --flake .

# Apply changes to system per flake
switch:
  darwin-rebuild switch --flake .

# Update the flake lock file
update:
  nix flake update

# Lint all files (similar to GitHub Actions), setup nix-shell
lint:
  nix develop --accept-flake-config .#lint

# format all the files, when in a nix-shell
format:
  nixpkgs-fmt .

# check all files (similar to GitHub Actions), when in a nix-shell
check:
  actionlint
  yamllint .
  selene .
  stylua --check .
  statix check
  nixpkgs-fmt --check .

# Check flake evaluation
flake:
  nix flake check --no-build --all-systems
