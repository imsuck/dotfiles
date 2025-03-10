{ pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellApplication {
      name = "update-nix-index-db";

      runtimeInputs = with pkgs; [
        curl
        wget
      ];

      text = ''
        org="nix-community"
        repo="nix-index-database"
        latest_tag=$(curl "https://api.github.com/repos/$org/$repo/releases/latest" -s | jq .tag_name -r)
        mkdir -p ~/.cache/nix-index/
        wget \
          "https://github.com/$org/$repo/releases/download/$latest_tag/index-${pkgs.system}" \
          -O ~/.cache/nix-index/files
      '';
    })
  ];
}
