local wezterm = require("wezterm")
return {
	default_cursor_style = "SteadyBar",
	font = wezterm.font("JetBrains Mono Nerd Font"),
	font_size = 16.0,
	enable_tab_bar = false,
	enable_wayland = true,
	window_background_opacity = 0.9,
	window_close_confirmation = "NeverPrompt",
	-- default_prog = { "nu" },
	default_prog = { "zsh" },
    color_scheme = 'Dracula',
}
