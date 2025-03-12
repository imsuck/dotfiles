{ ... }:
{
  programs.zathura = {
    enable = true;
    mappings = {
      i = "recolor";
      "<F1>" = ''focus_inputbar ":exec sh -c '~/scripts/zathura_open.sh history'"'';
      "<F2>" = ''focus_inputbar ":exec sh -c '~/scripts/zathura_open.sh search'"'';
      # Open pdf files from history
      O = ''feedkeys "<F1><Return><Return>q"'';
      # Open pdf files in home directory
      o = ''feedkeys "<F2><Return><Return>q"'';

      h = ''feedkeys "<C-Left>"'';
      j = ''feedkeys "<C-Down>"'';
      k = ''feedkeys "<C-Up>"'';
      l = ''feedkeys "<C-Right>"'';
      d = ''feedkeys "g<PageDown>e"'';
      u = ''feedkeys "g<PageUp>e"'';
    };
    options = {
      selection-clipboard = "clipboard";
      selection-notification = false;

      font = "Sans 10";
      guioptions = "shv";
      window-title-basename = true;
      statusbar-home-tilde = true;
      adjust-open = "width";

      recolor-keephue = true;
      # recolor-reverse-video = true;
      recolor-lightcolor = "rgba(0,0,0,0)";
      recolor-darkcolor = "#C0CAF5";
      default-bg = "rgba(36,40,59,0.9)";
      default-fg = "rgb(192,202,245)";

      index-bg = "rgba(36,40,59,0.0)";
      index-fg = "#C0CAF5";
      index-active-bg = "#414868";
      index-active-fg = "#C0CAF5";

      completion-bg = "#24283B";
      completion-fg = "#C0CAF5";
      completion-group-bg = "#1D202F";
      completion-group-fg = "#C0CAF5";
      completion-highlight-bg = "#414868";
      completion-highlight-fg = "#C0CAF5";

      notification-bg = "#24283B";
      notification-fg = "#FFFFFF";
      notification-error-bg = "#F7768E";
      notification-error-fg = "#FFFFFF";
      notification-warning-bg = "#E0AF68";
      notification-warning-fg = "#FFFFFF";

      scrollbar-bg = "rgba(36,40,59,0.0)";
      scrollbar-fg = "rgb(192,202,245)";

      inputbar-bg = "#24283B";
      inputbar-fg = "#C0CAF5";
      statusbar-bg = "#414868";
      statusbar-fg = "#C0CAF5";

      highlight-color = "rgba(55, 61, 90, 0.5)";
      highlight-active-color = "rgba(247, 118, 142, 0.5)";
    };
  };
}
