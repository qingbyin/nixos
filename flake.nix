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
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
  inputs =                                                                  # All flake references used to build my NixOS setup. These are dependencies.
    {
      nixpkgs.url = "nixpkgs/nixos-23.05";
      nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
      nur.url = "github:nix-community/NUR";
      # nixgl.url = "git+https://ghproxy.com/https://github.com/guibou/nixGL"; # OpenGL wrapper

      impermanence.url = "github:nix-community/impermanence";
      nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
      nixneovimplugins.url = "github:jooooscha/nixpkgs-vim-extra-plugins";

      home-manager = {                                                      # User Package Management
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };

    outputs = { nixpkgs, nixpkgs-unstable, home-manager, ... } @inputs:
    let                                                                     
      user = "qyin";
      system = "x86_64-linux";
      # Overlays-module makes "pkgs.unstable" available in home.nix
      overlay-unstable = final: prev: {
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true; # allow proprietary software
        overlays = [
            inputs.nixneovimplugins.overlays.default
            overlay-unstable
            inputs.nur.overlay
        ];
      };
    in 
    {
      homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
        # pass through arguments to home.nix
        extraSpecialArgs = {inherit inputs pkgs user;};
      };
    };
}
