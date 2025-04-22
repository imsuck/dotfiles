{ pkgs, ... }:

{
  home.file = {
    # super ad-hoc solution for nitrogen
    # ".gtk-2.0/2.10.0/engines/libmurrine.so".source =
    #   "${pkgs.gtk-engine-murrine}/lib/gtk-2.0/2.10.0/engines/libmurrine.so";
    # ".gtk-2.0/2.10.0/engines/libmurrine.la".source =
    #   "${pkgs.gtk-engine-murrine}/lib/gtk-2.0/2.10.0/engines/libmurrine.la";
    # ".gtk-2.0/2.10.0/engines/libclearlooks.so".source =
    #   "${pkgs.gtk_engines}/lib/gtk-2.0/2.10.0/engines/libclearlooks.so";
    # ".gtk-2.0/2.10.0/engines/libclearlooks.la".source =
    #   "${pkgs.gtk_engines}/lib/gtk-2.0/2.10.0/engines/libclearlooks.la";
  };
}
