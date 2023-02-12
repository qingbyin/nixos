# NixOS Installation

* Choose a `<hostname` from `./hosts/`
  * `desktop`:
  * `laptop`:
  * `work`:

* Choose a host to build
```bash
sudo nixos-rebuild switch --flake <path>#<hostname>
# For example
sudo nixos-rebuild switch --flake .#work
```

* Partitioning using `Gparted`
```bash
Device -> Cresate partition table -> gpt (efi boot)
Add new partition -> fileSystem:ex4/linux-swap
Manage flags -> boot for ext4
Label partitions
```

## TODO list

* [ ] Set a variable to check nvidia gpu instead of using hostname
* [ ] Use hostname "home", "work"
* [ ] Organize modules (put programs/ and editors/ into one app/)  

## Refs

* [MatthiasBenaets](https://github.com/MatthiasBenaets)
