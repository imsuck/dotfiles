{ pkgs, ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      clang-tools nil nixfmt-rfc-style ruff tinymist ruff
    ];

    settings = {
      theme = "base16_terminal_edit";

      editor = {
        line-number = "relative";
        color-modes = true;
        auto-format = false;
        idle-timeout = 0;
        shell = ["fish" "-c"];
        rulers = [80];
        completion-trigger-len = 1;
        completion-replace = true;
        bufferline = "multiple";
        end-of-line-diagnostics = "hint";
      };
      editor.cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "block";
      };
      editor.lsp = {
        display-messages = true;
        display-inlay-hints = false;
        display-signature-help-docs = false;
      };
      # editor.inline-diagnostics.cursor-line = "error";
      editor.statusline = {
        left = ["mode" "spacer" "spinner" "spacer" "version-control" "file-name" "read-only-indicator" "file-modification-indicator" "spacer" "diagnostics"];
        right = ["position" "total-line-numbers" "selections" "file-encoding" "file-line-ending"];
      };
      editor.indent-guides = {
        render = true;
        character = "▏"; # other things "▏", "┆", "┊"
        # skip-levels = 1;
      };

      keys.normal = {
        C-s = ":w";
        esc = ":q";
        A-up = ["extend_to_line_bounds" "delete_selection" "move_line_up" "paste_before" "collapse_selection"];
        A-k = ["extend_to_line_bounds" "delete_selection" "move_line_up" "paste_before" "collapse_selection"];
        A-down = ["extend_to_line_bounds" "delete_selection" "move_line_down" "goto_line_start" "paste_before" "collapse_selection"];
        A-j = ["extend_to_line_bounds" "delete_selection" "move_line_down" "goto_line_start" "paste_before" "collapse_selection"];

        backspace = {
          r = ":rl";
          c = ":o ~/.config/home-manager/helix.nix";
          R = ":config-reload";
          f = ":fmt";
          i = ":set lsp.display-inlay-hints false";
          I = ":set lsp.display-inlay-hints true";
        };
      };
      keys.select = {
        C-s = ":w";
        A-up = ["extend_to_line_bounds" "delete_selection" "move_line_up" "paste_before" "select_mode"];
        A-k = ["extend_to_line_bounds" "delete_selection" "move_line_up" "paste_before" "select_mode"];
        A-down = ["extend_to_line_bounds" "delete_selection" "move_line_down" "paste_before" "select_mode"];
        A-j = ["extend_to_line_bounds" "delete_selection" "move_line_down" "paste_before" "select_mode"];
      };
      keys.insert = {
        C-s = ":w";
        C-v = ":clipboard-paste-before";
        C-left = "move_prev_word_start";
        C-right = "move_next_word_end";
        A-p = "select_prev_sibling";
        A-n = "select_next_sibling";
        A-i = "shrink_selection";
        A-o = "expand_selection";
      };
    };

    languages = with pkgs; {
      language-server.clangd = {
        args = ["--header-insertion=never"];
        config = {
          fallbackFlags = [
            "-std=c++17" "-Wall" "-Wconversion"
            "-Wno-sign-conversion" "-Wno-shorten-64-to-32" "-Wno-unqualified-std-cast-call"
          ];
        };
      };
      language = [
        {
          name = "cpp";
          indent = { tab-width = 4; unit = "    "; };

          formatter.command = "clang-format";
          formatter.args =
            let
              style = lib.concatStrings [
                "-style={"
                "AllowShortIfStatementsOnASingleLine: WithoutElse,"
                "AllowShortLoopsOnASingleLine: true,"
                "BasedOnStyle: llvm,"
                "IndentWidth: 4,"
                "NamespaceIndentation: All,"
                "IndentCaseLabels: true,"
                "IndentPPDirectives: BeforeHash,"
                "SpaceAfterTemplateKeyword: false,"
                "}"
              ];
            in ["${style}"];
        }
        {
          name = "css";
          indent = { tab-width = 2; unit = "  "; };
          auto-format = true;
        }
        {
          name = "nix";

          formatter.command = "nixfmt";
        }
      ];
    };

    themes = {
      base16_terminal_edit = {
        inherits = "base16_transparent";

        "ui.menu" = { bg = "black"; };
        "ui.menu.selected" = { bg = "gray"; };
        "ui.help" = { bg = "black"; };
        "ui.menu.scroll" = { fg = "light-gray"; bg = "black"; };
        "ui.popup" = { bg = "black"; };
        "ui.selection" = { bg = "background_highlight"; };
        "ui.statusline" = { fg = "white"; bg = "black"; };
        "ui.statusline.inactive" = { fg = "gray"; bg = "black"; };
        "ui.cursor" = { fg = "black"; bg = "light-gray"; };
        "ui.cursor.primary" = { fg = "black"; bg = "white"; };
        "ui.virtual.inlay-hint" = { fg = "gray"; };
        "ui.virtual.inlay-hint.parameter" = { fg = "gray"; };
        "ui.virtual.inlay-hint.type" = { fg = "gray"; };
        "ui.bufferline" = { };
        "ui.bufferline.active" = { bg = "gray"; };

        "hint" = { };


        "ui.statusline.normal" = { fg = "green"; modifiers = ["bold" "reversed"]; };
        "ui.statusline.insert" = { fg = "blue"; modifiers = ["bold" "reversed"]; };
        "ui.statusline.select" = { fg = "yellow"; modifiers = ["bold" "reversed"]; };

        "ui.cursorline.primary" = { bg = "black"; };

        "ui.virtual.indent-guide" = "gray";
        "ui.virtual.ruler" = { bg = "black"; };
        "ui.virtual.jump-label" = { fg = "yellow"; modifiers = ["bold"]; underline = { style = "line"; }; };

        "comment" = { fg = "comment"; modifiers = ["italic"]; };
        "punctuation" = { fg = "comment"; };

        palette = {
          comment = "#565f89";
          background_highlight = "#373d5a";
        };
      };
    };
  };
}
