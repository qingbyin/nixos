# NixOS Installation

1. Prepare a 64-bit nixos [minimal iso image](https://channels.nixos.org/nixos-22.11/latest-nixos-minimal-x86_64-linux.iso)
   and burn it, then enter the live system.

2. Partitioning using `Gparted`
```bash
Device -> Cresate partition table -> gpt (efi boot)
Add new partition -> fileSystem:ex4/linux-swap
Manage flags -> boot for ext4
Label partitions
```

3. Generate a basic configuration

```bash
nixos-generate-config --root /mnt
```

4. Clone/copy this repository locally

```bash
git clone https://github.com/qyin/flakes.git ~/.nixos 
cd ~/.nixos
nix develop --extra-experimental-features 'nix-command flakes'
```

4 Choose a `<hostname>` from `./hosts/`
  * `desktop`:
  * `laptop`:
  * `work`:

5. Move `hardware-configuration.nix` to the host directory
```bash
cp /mnt/etc/nixos/hardware-configuration.nix ~/.nixos/hosts/<hostname>/hardware-configuration.nix
```
- May modify root directory with `tmpfs` 

6. Build the selected host
```bash
nixos-install --no-root-passwd --flake .#<hostname>
```

7. Reboot
```bash
reboot
```

## Refs

* [MatthiasBenaets](https://github.com/MatthiasBenaets)
