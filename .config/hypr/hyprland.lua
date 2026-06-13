hl.monitor({
  output = "eDP-1",
  mode = "1920x1080",
  position = "0x0",
  scale = "1"
})

-- Environment

hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("_JAVA_AWT_WM_NONREPARENTING", "1")

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_CURRENT_SESSION_TYPE", "wayland")

hl.env("GDK_BACKEND", "wayland")
hl.env("KITTY_ENABLE_WAYLAND", "1")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("EGL_PLATFORM", "wayland")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("GTK_USE_PORTAL", "0")

hl.env("QT_PLUGIN_PATH","/usr/lib/qt/plugins/")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION","1")
hl.env("QT_QPA_PLATFORM","wayland")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("HYPRCURSOR_SIZE", "24")

-- GTK 4 Fix for Hyprland
hl.env("GTK_THEME", "gtk-master")

-- Nvidia stuff
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GL_VRR_ALLOWED", "1")
hl.env("WLR_NO_HARDWARE_CURSORS", "1")
hl.env("VDPAU_DRIVER", "nvidia")
hl.env("__GL_SYNC_TO_VBLANK", "0")
hl.env("NVD_BACKEND", "direct")

hl.on("hyprland.start", function () 
  hl.exec_cmd("~/.config/autostart/startup.sh")
  hl.exec_cmd("xrdb -merge ~/.config/X11/xresources")
end)

hl.config({
  general = {
    gaps_in = 2.5,
    gaps_out = 5,
    border_size = 2,

    col = {
      active_border = "rgb(ff007c)",
      inactive_border = "rgb(1F1F1F)",
    },

    allow_tearing = false,

    layout = "dwindle",
  },

  decoration = {
    rounding = 0,
    fullscreen_opacity = 1.0,

    blur = {
      enabled = true,
      size = 6,
      passes = 3,
      new_optimizations = true,
      xray = false,
      ignore_opacity = true,
    },

    shadow = {
      enabled = true,
      range = 20,
      render_power = 2,
    },
  },

  animations = {
    enabled = false,
  },

  dwindle = {
    --pseudotile = true,
    preserve_split = true,
    force_split = 2,
  },

  master = {
    new_status = "master",
  }, 

  misc = {
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    force_default_wallpaper = -1,
    mouse_move_enables_dpms = true,
    animate_manual_resizes = true,
    mouse_move_focuses_monitor = true,
  },

  input = {
    kb_layout = "us",
    kb_options = "ctrl:nocaps",

    repeat_delay = 250,
    repeat_rate = 69,

    follow_mouse = 1,
    natural_scroll = 0,
    force_no_accel = 1,

    touchpad = {
      tap_to_click = 1,
      natural_scroll = 1,
      scroll_factor = 0.5,
    },
  },
})

--hl.curve("linear", { type = "bezier", points = { {0.23, 1}, {0.32, 1} } })
--
--hl.animation({ leaf = "borderangle", enabled = true, speed = 50, bezier = "linear", style = "loop" })
--hl.animation({ leaf = "workspaces",  enabled = false })
--hl.animation({ leaf = "windows",     enabled = false })

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace",
})

hl.device({
  name = "elan0710:01-04f3:30ed-touchpad",
  sensitivity = 0.1,
})

-- binds and variables
local home = os.getenv("HOME")
local config = home .. "/.config/hypr"
local scripts = home .. "/.scripts"

-- Apps
local terminal    = "wezterm"
local altTerminal = "alacritty"
local launcher    = "rofi -show drun"
local filemanager = "dolphin"

-- ---- NORMAL BINDS ----
hl.bind("SUPER + Return",       hl.exec_cmd(terminal))
hl.bind("ALT + Return",         hl.exec_cmd(altTerminal))
hl.bind("SUPER + D",            hl.exec_cmd(launcher))
hl.bind("SUPER + W",            hl.exec_cmd(scripts .. "/misc/wallmanager"))
hl.bind("SUPER + E",            hl.exec_cmd(scripts .. "/emojis/emoji.sh"))
hl.bind("SUPER + SHIFT + X",    hl.exec_cmd(scripts .. "/system/waylock.sh"))
hl.bind("SUPER + N",            hl.exec_cmd(config .. "/scripts/toggle_shader"))
hl.bind("SUPER + G",            hl.exec_cmd(config .. "/scripts/hyprgamemode"))

-- ---- HYPRLAND ----
hl.bind("SUPER + SHIFT + Q",    hl.window.close())
hl.bind("SUPER + SHIFT + M",    hl.exit())
hl.bind("SUPER + V",            hl.window.float({ action = "toggle" }))
hl.bind("SUPER + P",            hl.window.pseudo())
hl.bind("SUPER + F",            hl.window.fullscreen())

-- ---- FUNCTION / MEDIA KEYS ----
hl.bind("XF86Calculator",       hl.exec_cmd("galculator"))
hl.bind("XF86Tools",            hl.exec_cmd("foot -e yt-music"))
hl.bind("XF86Search",           hl.exec_cmd("rofi -no-lazy-grab -show file-browser-extended -icon-theme Dracula"))
hl.bind("XF86Explorer",         hl.exec_cmd(filemanager))

-- ---- WORKSPACE NAV ----
hl.bind("SUPER + Tab",          hl.dsp.focus({ workspace = "previous" }))

-- ---- MOUSE BINDS ----
hl.bind("SUPER + mouse:272",    hl.dsp.window.drag(),   { mouse = true })
hl.bind("SUPER + mouse:273",    hl.dsp.window.resize(), { mouse = true })

-- ---- FOCUS ----
hl.bind("SUPER + h",            hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + l",            hl.dsp.focus({ direction = "r" }))
hl.bind("SUPER + k",            hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + j",            hl.dsp.focus({ direction = "d" }))
hl.bind("SUPER + left",         hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + right",        hl.dsp.focus({ direction = "r" }))
hl.bind("SUPER + up",           hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + down",         hl.dsp.focus({ direction = "d" }))

-- ---- WORKSPACES ----
hl.bind("SUPER + 1",            hl.exec_cmd("/home/swarn/.config/hypr/scripts/workspace 1"))
hl.bind("SUPER + 2",            hl.exec_cmd("/home/swarn/.config/hypr/scripts/workspace 2"))
hl.bind("SUPER + 3",            hl.exec_cmd("/home/swarn/.config/hypr/scripts/workspace 3"))
hl.bind("SUPER + 4",            hl.exec_cmd("/home/swarn/.config/hypr/scripts/workspace 4"))
hl.bind("SUPER + 5",            hl.exec_cmd("/home/swarn/.config/hypr/scripts/workspace 5"))
hl.bind("SUPER + 6",            hl.exec_cmd("/home/swarn/.config/hypr/scripts/workspace 6"))
hl.bind("SUPER + 7",            hl.exec_cmd("/home/swarn/.config/hypr/scripts/workspace 7"))
hl.bind("SUPER + 8",            hl.exec_cmd("/home/swarn/.config/hypr/scripts/workspace 8"))
hl.bind("SUPER + 9",            hl.exec_cmd("/home/swarn/.config/hypr/scripts/workspace 9"))
hl.bind("SUPER + 0",            hl.exec_cmd("/home/swarn/.config/hypr/scripts/workspace 10"))

hl.bind("SUPER + SHIFT + 1",    hl.dsp.window.move({ workspace = 1 }))
hl.bind("SUPER + SHIFT + 2",    hl.dsp.window.move({ workspace = 2 }))
hl.bind("SUPER + SHIFT + 3",    hl.dsp.window.move({ workspace = 3 }))
hl.bind("SUPER + SHIFT + 4",    hl.dsp.window.move({ workspace = 4 }))
hl.bind("SUPER + SHIFT + 5",    hl.dsp.window.move({ workspace = 5 }))
hl.bind("SUPER + SHIFT + 6",    hl.dsp.window.move({ workspace = 6 }))
hl.bind("SUPER + SHIFT + 7",    hl.dsp.window.move({ workspace = 7 }))
hl.bind("SUPER + SHIFT + 8",    hl.dsp.window.move({ workspace = 8 }))
hl.bind("SUPER + SHIFT + 9",    hl.dsp.window.move({ workspace = 9 }))
hl.bind("SUPER + SHIFT + 0",    hl.dsp.window.move({ workspace = 10 }))

-- ---- RESIZE ----
hl.bind("SUPER + CTRL + h",     hl.window.resize({ x = -100, y = 0 }))
hl.bind("SUPER + CTRL + l",     hl.window.resize({ x =  100, y = 0 }))
hl.bind("SUPER + CTRL + k",     hl.window.resize({ x = 0, y = -100 }))
hl.bind("SUPER + CTRL + j",     hl.window.resize({ x = 0, y =  100 }))

-- ---- AUDIO ----
hl.bind("XF86AudioRaiseVolume", hl.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"),  { locked = true })
hl.bind("XF86AudioLowerVolume", hl.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"),  { locked = true })
hl.bind("XF86AudioMute",        hl.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioPlay",        hl.exec_cmd("playerctl play-pause"),                      { locked = true })
hl.bind("XF86AudioNext",        hl.exec_cmd("playerctl next"),                            { locked = true })
hl.bind("XF86AudioPrev",        hl.exec_cmd("playerctl previous"),                        { locked = true })

-- ---- SCREENSHOT ----
hl.bind("Print",                hl.exec_cmd(config .. "/scripts/screenshot fullsave"), { locked = true })
hl.bind("SUPER + SHIFT + S",    hl.exec_cmd(config .. "/scripts/screenshot selclip"))

-- ---- BRIGHTNESS ----
hl.bind("XF86MonBrightnessUp",   hl.exec_cmd("brightnessctl set +5%"), { locked = true })
hl.bind("XF86MonBrightnessDown", hl.exec_cmd("brightnessctl set 5%-"), { locked = true })
hl.bind("SUPER + F1",            hl.exec_cmd("brightnessctl set +5%"))
hl.bind("SUPER + F2",            hl.exec_cmd("brightnessctl set 5%-"))

