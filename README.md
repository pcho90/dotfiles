# Nix Dotfiles with Home Manager

### Installation:
1. `nix build .#homeConfigurations.{host}.activationPackage --extra-experimental-features flakes --extra-experimental-features nix-command`
2. `result/activate`
