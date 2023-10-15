{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    
    # nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";

    # only needed if you use as a package set:
    # nixpkgs-wayland.inputs.nixpkgs.follows = "nixpkgs-unstable";

    # home-manager.url = "github:nix-community/home-manager/release-23.05";
    # home-manager.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs = inputs @ { self, nixpkgs, home-manager, ... }: {
    nixosConfigurations."vm" =
    let
      system = "x86_64-linux";
      specialArgs = {
        # pkgs-wayland = import nixpkgs-wayland;
        inherit system;
        inherit inputs;
      };
    in nixpkgs.lib.nixosSystem {
      inherit system;
      inherit specialArgs;
        # specialArgs = {
        #   inherit inputs;
        # };
      modules = [
        ({pkgs, config, ... }: {
          config = {
            # nix.settings = {
            #   # add binary caches
            #   trusted-public-keys = [
            #     "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
            #     "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
            #   ];
            #   substituters = [
            #     "https://cache.nixos.org"
            #     "https://nixpkgs-wayland.cachix.org"
            #   ];
            # };

            # use it as an overlay
            # nixpkgs.overlays = [ inputs.nixpkgs-wayland.overlay ];

            # or, pull specific packages (built against inputs.nixpkgs, usually `nixos-unstable`)
            # environment.systemPackages = [
            #   inputs.nixpkgs-wayland.packages.${system}.waybar
            # ];
          };
        })
        # home-manager.nixosModules.home-manager {
        #   home-manager.useGlobalPkgs = true;
        #   home-manager.useUserPackages = true;
        #   home-manager.users.stephane.imports = [ ./home.nix ];
        #   home-manager.extraSpecialArgs = specialArgs;
        # }
        ./configuration.nix
      ];
    };
  };
}
