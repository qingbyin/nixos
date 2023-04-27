
.ONSHELL:
install:
	sudo apt install git curl
	curl -L https://nixos.org/nix/install | sh -s
	. ~/.nix-profile/etc/profile.d/nix.sh
	mkdir -p ~/.config/nix
	echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
	git checkout ubuntu
	nix run --impure .#homeConfigurations.qyin.activationPackage

build:
	home-manager --impure switch --flake .#qyin

kitty:
	sudo apt install kitty

i3-deps:
	sudo apt install i3lock
	sudo apt install blueman

docker:
	sudo apt-get remove docker docker-engine docker.io containerd runc
	sudo apt-get update
	sudo apt install ca-certificates
	# Add Docker's official GPG key
	sudo mkdir -m 0755 -p /etc/apt/keyrings
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
	echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	sudo apt-get update
	sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
	# rootless docker
	sudo groupadd docker
	sudo usermod -aG docker $USER
	newgrp docker

v2raya:
	# Install v2ray
	curl -Ls https://mirrors.v2raya.org/go.sh | sudo bash
	# Install v2rayA
	wget -qO - https://apt.v2raya.org/key/public-key.asc | sudo tee /etc/apt/trusted.gpg.d/v2raya.asc
	echo "deb https://apt.v2raya.org/ v2raya main" | sudo tee /etc/apt/sources.list.d/v2raya.list
	sudo apt update
	sudo apt install v2raya



