.PHONY: clean update upgrade

upgrade:
	home-manager switch --flake .#imsuck

update:
	nix flake update

clean:
	nix-collect-garbage --delete-older-than 7d
