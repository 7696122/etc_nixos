{
  description = "NixOS configuration";

  inputs = {
    # Core dependencies.
    # Two inputs so I can track them separately at different rates.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "nixpkgs/master";

    # home-manager.url = "github:nix-community/home-manager";
    home-manager.url = "github:rycee/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Extras
    emacs-overlay.url  = "github:nix-community/emacs-overlay";
    nixos-hardware.url = "github:nixos/nixos-hardware";
  };

  # https://github.com/nix-community/home-manager#nix-flakes
  outputs = { self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.mnmlst#  = {
      # hostname
      = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.user = import ./home.nix;
          }
        ];
      };
    };
  # };
}
