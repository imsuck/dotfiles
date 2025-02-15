.PHONY: clean backup update upgrade

upgrade:
	home-manager switch --flake .

update:
	nix flake update

backup:
	home-manager switch --flake . -b old 

clean:
	nix-collect-garbage --delete-older-than 7d
