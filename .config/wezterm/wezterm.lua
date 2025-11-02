local wezterm = require("wezterm")

function scheme_for_appearance(appearance)
  if appearance:find "Dark" then
    return "Catppuccin Mocha"
  else
    return "Catppuccin Latte"
  end
end

return {
  default_cursor_style = "SteadyBar",
  font = wezterm.font_with_fallback {
    "JetBrainsMono Nerd Font"
  },
  font_size = 16.0,
  enable_tab_bar = false,
  enable_wayland = true,
  window_background_opacity = 0.9,
  window_close_confirmation = "NeverPrompt",
  default_prog = { "zsh" },
  color_scheme = "Dracula (Official)",
}

