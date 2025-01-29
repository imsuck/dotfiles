.PHONY: upgrade
upgrade:
	home-manager switch --flake .#imsuck

.PHONY: update
update:
	nix flake update

.PHONY: clean
clean:
	nix-collect-garbage --delete-older-than 7d
