# Nix Home Manager + Ubuntu

1. Install `nix`

```bash
sh <(curl -L https://nixos.org/nix/install)
```

2. Enable `flakes`

```bash
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

3. Clone/copy this repository locally

```bash
nix-shell -p git
git clone https://github.com/qyin/flakes.git ~/.nix 
cd ~/.nix
```

4. First Build 

```bash
nix build .#homeConfigurations.<host>.activationPackage
./result/activate
```

5. Update (Rebuild). After the first installation, we don’t need to target /activate inside /result.

```bash
home-manager switch --flake ~/.nix#qyin
```

## Refs

* [MatthiasBenaets](https://github.com/MatthiasBenaets)
