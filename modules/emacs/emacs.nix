# Doom Emacs

{ config, pkgs, nix-doom-emacs, ... }:

{
  imports = [ nix-doom-emacs.hmModule ];

  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./doom.d;
  };

  # Dependencies
  home.packages = with pkgs; [
    ripgrep
    coreutils
    fd
  ];                                             # Dependencies
}
