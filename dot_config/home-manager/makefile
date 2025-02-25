.PHONY: clean backup _build switch update _update

switch: _build
	home-manager switch --flake .

update: _update _build
	@read -p "Switch profile? "
	home-manager switch --flake .

backup:
	home-manager switch --flake . -b old 

clean:
	nix-collect-garbage --delete-older-than 7d

_build:
	home-manager build -L --flake .
	@nvd diff ~/.local/state/home-manager/gcroots/current-home result
	@rm result

_update:
	nix flake update
