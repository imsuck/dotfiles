.PHONY: clean backup _build switch update _update

switch: _build
	home-manager switch --flake .

update: _update _build
	@read -p "Switch profile? [Y/n] " ans && \
		if [ $${ans:-'y'} = 'y' ]; then \
			home-manager switch --flake .; \
			rm flake.lock.old; \
		else \
			mv flake.lock.old flake.lock; \
		fi

backup:
	home-manager switch --flake . -b old 

clean:
	nix-collect-garbage --delete-older-than 7d

init:
	nix run home-manager/master -- switch -b old

_build:
	home-manager build -L --flake .
	@nvd diff ~/.local/state/home-manager/gcroots/current-home result
	@rm result

_update:
	@cp flake.lock flake.lock.old
	nix flake update
