local wezterm = require "wezterm"

local colors = wezterm.color.get_builtin_schemes()['tokyonight-storm']
colors.selection_bg = "#373d5a"

return {
  font = wezterm.font_with_fallback {
    -- "Comic Mono",
    -- { family = "Liga Roboto Mono" },
    {
      family = "Mono",
      -- weight = "Regular",
      harfbuzz_features = {"ss02", "ss07"},
    },
    "Noto Sans Mono",
    "Twitter Color Emoji",
    "Font Awesome 6 Brands",
  },
  font_size = 12.0,
  -- font_size = 8.5,
  -- cell_width = 1.1,
  line_height = 0.9,

  color_schemes = {["tokyonight-storm"] = colors},
  color_scheme = "tokyonight-storm",

  enable_tab_bar = false,

  default_cursor_style = "SteadyBar",
  cursor_blink_ease_in = "Constant",
  cursor_blink_ease_out = "Constant",
  cursor_blink_rate = 500,

  window_background_opacity = 1.0,
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

  front_end = "WebGpu",

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
