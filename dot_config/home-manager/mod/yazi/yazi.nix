{ ... }:

{
  programs.yazi = {
    enable = true;
    settings = {
      preview = {
        image_delay = 100;
      };
    };
    initLua = ./init.lua;
    plugins = {
      arrow = ./plugins/arrow;
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
