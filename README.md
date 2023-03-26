# Nix Home Manager + Ubuntu

## Auto Installation

Use `make` with `Makefile`.

## Manual Installation

1. Install `nix`

```bash
sh <(curl -L https://nixos.org/nix/install)
```

2. Enable `flakes`

```bash
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

3. Clone/copy this repository locally

```bash
nix-shell -p git
git clone https://github.com/qyin/flakes.git ~/.nix 
cd ~/.nix
```

4. Install Home Manager and apply the configuration by
   (`--impure` is required for NixGL)

```bash
nix run --impure .#homeConfigurations.<host>.activationPackage
./result/activate
```

5. Once home-manager is installed, update (Rebuild) the configuration

```bash
home-manager --impure switch --flake .#qyin
```

## Refs

* [MatthiasBenaets](https://github.com/MatthiasBenaets)
