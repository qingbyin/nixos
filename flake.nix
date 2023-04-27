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
      nixgl.url = "git+https://ghproxy.com/https://github.com/guibou/nixGL"; # OpenGL wrapper

      impermanence.url = "github:nix-community/impermanence";
      nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";

      home-manager = {                                                      # User Package Management
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };
    };

    outputs = { nixpkgs, home-manager, ... } @inputs:
    let                                                                     
      user = "qyin";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true; # allow proprietary software
        config.permittedInsecurePackages = [ "qtwebkit-5.212.0-alpha4" ];
        overlays = [ inputs.nixgl.overlay ];
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
