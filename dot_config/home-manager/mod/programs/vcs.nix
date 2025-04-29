{ pkgs, ... }:

{
  home.packages = with pkgs; [
    git-filter-repo
  ];
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
    settings.git_protocol = "https";
    extensions = with pkgs; [ gh-dash ];
  };
  programs.git = {
    enable = true;
    package = pkgs.nullpkg;

    userName = "imsuck";
    userEmail = "imsuck12@gmail.com";

    extraConfig = {
      credential.credentialStore = "gpg";

      init.defaultBranch = "main";

      diff.colorMoved = "default";
      merge.conflictstyle = "zdiff3";
    };

    delta.enable = true;
    delta.options = {
      line-numbers = true;
      navigate = true;

      line-numbers-minus-style = "red bold";
      line-numbers-zero-style = "white";
      line-numbers-plus-style = "green bold";

      minus-style = "syntax '#472e42'";
      minus-emph-style = "syntax '#7c4055'";
      plus-style = "syntax '#32403d'";
      plus-emph-style = "syntax '#516847'";

      syntax-theme = "base16";
    };
  };
}
