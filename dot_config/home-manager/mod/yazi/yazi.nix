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
          { name = "*.kra"; run = "krita"; }
          { mime = "image/webp"; run = "magick"; }
        ];
        prepend_preloaders = [
          { name = "*.kra"; run = "krita"; }
          { mime = "image/webp"; run = "magick"; }
        ];
      };
    };
    initLua = ./init.lua;
    plugins = {
      arrow = ./plugins/arrow;
      krita = ./plugins/krita;
    };
    keymap = {
      manager = {
        prepend_keymap = [
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
            run = "plugin arrow --args=1";
          }
          {
            on = "k";
            run = "plugin arrow --args=-1";
          }
        ];
      };
    };
  };
}
