.PHONY: update
update:
	home-manager switch --flake .#imsuck

.PHONY: clean
clean:
	nix-collect-garbage --delete-older-than 7d
