{ ... }:

{
  programs.yazi = {
    enable = true;
    settings = {
      preview = {
        image_delay = 100;
      };
      plugin = {
        prepend_previewers = [
          {
            name = "*.kra";
            run = "krita";
          }
          {
            mime = "image/webp";
            run = "magick";
          }
          {
            mime = "image/adobe.photoshop";
            run = "psd";
          }
        ];
        prepend_preloaders = [
          {
            name = "*.kra";
            run = "krita";
          }
          {
            mime = "image/webp";
            run = "magick";
          }
          {
            mime = "image/adobe.photoshop";
            run = "psd";
          }
        ];
      };
    };
    initLua = ./init.lua;
    plugins = {
      arrow = ./plugins/arrow;
      krita = ./plugins/krita;
      psd = ./plugins/psd;
    };
    keymap = {
      manager = {
        prepend_keymap = [
          {
            on = "!";
            run = "shell --block '$SHELL'";
          }
          {
            on = "o";
            run = "shell --confirm --orphan 'handlr open \"$0\"'";
          }
          {
            on = "e";
            run = "shell --confirm --block '$EDITOR \"$0\"'";
          }

          {
            on = "j";
            run = "plugin arrow 1";
          }
          {
            on = "k";
            run = "plugin arrow -1";
          }

          {
            on = "<C-n>";
            run = "shell --confirm 'ripdrag -x -i -s 64 \"$@\" 2>/dev/null'";
          }
        ];
      };
    };
    theme = {
      manager = {
        tab_active = {
          bg = "blue";
          fg = "black";
        };
        tab_inactive = {
          fg = "blue";
        };
        count_copied = {
          bg = "green";
          fg = "black";
        };
        count_cut = {
          bg = "red";
          fg = "black";
        };
        count_selected = {
          bg = "yellow";
          fg = "black";
        };
        border_style.fg = "darkgray";
      };
      mode = {
        normal_main = {
          bg = "blue";
          fg = "black";
        };
        normal_alt = {
          bg = "darkgray";
          fg = "blue";
        };
        select_main = {
          bg = "green";
          fg = "black";
        };
        select_alt = {
          bg = "darkgray";
          fg = "green";
        };
        unset_main = {
          bg = "magenta";
          fg = "black";
        };
        unset_alt = {
          bg = "darkgray";
          fg = "magenta";
        };
      };
      status = {
        sep_left = {
          open = "";
          close = "";
        };
        sep_right = {
          open = "";
          close = "";
        };
      };
    };
  };
}
