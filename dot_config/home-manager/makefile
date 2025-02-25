.PHONY: clean backup switch update

switch:
	home-manager switch --flake .

update:
	nix flake update
	home-manager build --flake .
	nvd diff ~/.local/state/home-manager/gcroots/current-home result
	rm result
	@read -p "Switch profile? "
	$(MAKE) switch

backup:
	home-manager switch --flake . -b old 

clean:
	nix-collect-garbage --delete-older-than 7d
