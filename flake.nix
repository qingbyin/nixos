{
  description = "My Personal NixOS System Flake Configuration";
  nixConfig = {                                   
    auto-optimise-store = true;           # Deduplicate and optimise syslinks in nix store
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://nix-community.cachix.org"
      "https://cache.nixos.org/"
    ];
    trusted-substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://nix-community.cachix.org"
    ];
  };
  inputs =                                                                  # All flake references used to build my NixOS setup. These are dependencies.
    {
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
      nur.url = "github:nix-community/NUR";

      # Tools to customize ISO image
      nixos-generators = {
        url = github:nix-community/nixos-generators;
        inputs.nixpkgs.follows = "nixpkgs";
      };
      # A collection covers common hardware
      nixos-hardware.url = "github:nixos/nixos-hardware";

      impermanence.url = "github:nix-community/impermanence";
      nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";

      home-manager = {                                                      # User Package Management
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };

    # Function that tells my flake which to use and what do what to do with the dependencies.
    outputs = { nixpkgs, home-manager, ... } @inputs:
    let                                                                     
      user = "qyin";
      # location = "$HOME/.nixos"; # the path of this NixOS config
      system = "x86_64-linux";
      # Home-manager requires 'pkgs' instance
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true; # allow proprietary software
        config.permittedInsecurePackages = [ "qtwebkit-5.212.0-alpha4" ];
      };
    in 
    {
      nixosConfigurations.vm = nixpkgs.lib.nixosSystem {
        inherit system; # Specify nixos platform of this host
        specialArgs = {inherit inputs pkgs user;}; # args pass to modules
        modules = [
          ./configuration.nix 
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true; # Use the system level nixpkgs
            home-manager.useUserPackages = true; # Install packages to /etc/profiles
            home-manager.users.${user} = import ./home.nix {inherit pkgs user;};
          }
        ];
      };
    };
}
