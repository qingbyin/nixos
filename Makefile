
install:
	sudo apt install git curl
	sh <(curl -L https://nixos.org/nix/install)
	mkdir -p ~/.config/nix
	echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
	git clone https://github.com/qyin/flakes.git ~/.nix 
	nix run --impure ~/.nix/#homeConfigurations.qyin.activationPackage
	source ~/.nix/result/activate

build:
	home-manager --impure switch --flake .#qyin

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
