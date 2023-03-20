local wezterm = require "wezterm"

return {
  font = wezterm.font_with_fallback {
    -- "Comic Mono",
    -- { family = "Liga Roboto Mono", weight = "Medium" },
    {
      family = "Fira Code",
      -- weight = "Medium",
      harfbuzz_features = {"ss02", "ss07", "ss09"},
    },
    "Font Awesome 6 Brands",
  },
  font_size = 10.0,
  -- font_size = 8.5,
  -- cell_width = 1.1,

  color_scheme = "tokyonight-storm",

  enable_tab_bar = false,
  enable_wayland = false,

  default_cursor_style = "BlinkingBar",
  cursor_blink_ease_in = "Constant",
  cursor_blink_ease_out = "Constant",
  cursor_blink_rate = 500,

  window_background_opacity = 0.9,
  window_padding = {
    left = 10,
    right = 10,
    top = 10,
    bottom = 10,
  },
  skip_close_confirmation_for_processes_named = {
    "bash",
    "sh",
    "fish",
    "tmux",
    "zellij",
  },
  window_close_confirmation = 'NeverPrompt',
  -- for tiling WMs
  adjust_window_size_when_changing_font_size = false,

  keys = {
    {
      -- Needs fish keybind set up
      key = "Backspace",
      mods = "CTRL",
      action = wezterm.action.SendKey {
        key = "Backspace",
        mods = "ALT",
      },
    }
  }
}
