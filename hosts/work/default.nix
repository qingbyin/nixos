#
#  Specific system configuration settings

{ pkgs, lib, user, ... }:

{
  imports =                                               # For now, if applying to other system, swap files
    # [(import ./hardware-configuration.nix)] ++            # Current system hardware config @ /etc/nixos/hardware-configuration.nix
    [
    (import ../../modules/desktop/hyprland/default.nix)  # Window Manager
    ];
    # (import ../../modules/desktop/virtualisation) ++      # Virtual Machines & VNC
    # (import ../../modules/hardware) ++                    # Hardware devices
    # (import ../../modules/hardware/work);                 # Hardware specific quirks

  boot = {                                      # Boot options
    kernelPackages = pkgs.linuxPackages_latest;
    #initrd.kernelModules = [ "amdgpu" ];       # Video drivers

    loader = {                                  # EFI Boot
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      #systemd-boot = {
      #  enable = true;
      #  configurationLimit = 5;                 # Limit the amount of configurations
      #};
      # grub = {                                  # Most of grub is set up for dual boot
      #   enable = true;
      #   version = 2;
      #   devices = [ "nodev" ];
      #   efiSupport = true;
      #   useOSProber = true;                     # Find all boot options
      #   configurationLimit = 2;
      #   default=2;
      # };
      timeout = null;                           # Grub auto select time
    };
  };

  environment = {                               # Packages installed system wide
    systemPackages = with pkgs; [               # This is because some options need to be configured.
      nil # Nix language server
    ];
  };

  # Control the backlight without X service (see https://nixos.wiki/wiki/Backlight)
  programs = {                                  
    dconf.enable = true;
    light.enable = true;
  };

  services = {
    tlp.enable = true;                          # TLP and auto-cpufreq for power management
    auto-cpufreq.enable = true;
    blueman.enable = true;                      # Bluetooth
  };
}
