local wezterm = require("wezterm")
local home = os.getenv("HOME")
--wezterm.add_to_config_reload_watch_list(home.."/.cache/wal")
return {
  --color_scheme_dirs = {home.."/.cache/wal"},
  --color_scheme = "wezterm-wal",
  default_cursor_style = "SteadyBar",
  font = wezterm.font_with_fallback {
    "JetBrains Mono Nerd Font"
  },
  font_size = 16.0,
  enable_tab_bar = false,
  enable_wayland = true,
  window_background_opacity = 0.9,
  window_close_confirmation = "NeverPrompt",
  default_prog = { "zsh" },
  color_scheme = "Dracula (Official)",
}
