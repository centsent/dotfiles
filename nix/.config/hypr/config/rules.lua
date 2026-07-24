-- ============= Workspace Definitions =============
hl.workspace_rule({ workspace = "1", monitor = "DP-1", default_name = "" })
hl.workspace_rule({ workspace = "2", monitor = "HDMI-A-1", default_name = "" })
hl.workspace_rule({ workspace = "3", monitor = "HDMI-A-1", default_name = "" })
hl.workspace_rule({ workspace = "4", monitor = "HDMI-A-1", default_name = "" })
hl.workspace_rule({ workspace = "5", monitor = "HDMI-A-1", default_name = "" })
hl.workspace_rule({ workspace = "6", monitor = "HDMI-A-1", default_name = "󰦬" })
hl.workspace_rule({ workspace = "7", monitor = "HDMI-A-1", default_name = "" })
hl.workspace_rule({ workspace = "8", monitor = "HDMI-A-1", default_name = "" })

-- ============= Consolidated Window Rules =============
-- ----------------- Workspace Assignment -----------------
-- Terminal (Workspace 1)
hl.window_rule({ match = { class = "Alacritty" }, workspace = "1" })

-- Browser (Workspace 2)
hl.window_rule({ match = { class = "firefox-esr|chromium" }, workspace = "2" })

-- Notes (Workspace 3)
hl.window_rule({ match = { class = ".*obsidian.*" }, workspace = "3" })

-- Android (Workspace 4)
hl.window_rule({ match = { class = "jetbrains-studio|code" }, workspace = "4" })
hl.window_rule({ match = { class = "^(AndroidEmulator)$" }, workspace = "4" })
hl.window_rule({ match = { class = "^(qemu-system-.*)$" }, workspace = "4" })
hl.window_rule({ match = { class = "Emulator" }, workspace = "4" })

-- Social (Workspace 5)
hl.window_rule({ match = { class = "^(org.telegram.desktop|wechat)$" }, workspace = "5", float = true })

-- Misc (Workspace 6)
hl.window_rule({ match = { class = ".*kitty.*" }, workspace = "6" })

-- ----------------- Visual Properties -----------------
-- Opacity Rules
-- The global default now lives in decoration.lua (active 0.90 / inactive 0.80).
-- Only deviations from it belong here.

-- The terminal carries the least detail per pixel, so it can take the most.
hl.window_rule({ match = { class = "Alacritty" }, opacity = "0.82 0.70" })

-- Kept fully opaque: transparency over video or a photo looks like a rendering
-- fault, and the emulator has to show true colours to be worth anything.
hl.window_rule({ match = { class = "^(mpv|vlc|imv|org.gnome.Loupe)$" }, opacity = "1.0 1.0" })
hl.window_rule({ match = { class = "^(AndroidEmulator|Emulator)$" }, opacity = "1.0 1.0" })
hl.window_rule({ match = { class = "^(qemu-system-.*)$" }, opacity = "1.0 1.0" })
hl.window_rule({ match = { class = "jetbrains-studio" }, opacity = "1.0 1.0" })

-- Floating Windows
hl.window_rule({ match = { class = "(wpa_gui|pavucontrol|blueman-manager)" }, float = true })
hl.window_rule({ match = { class = ".*kitty.*" }, float = true })
hl.window_rule({ match = { title = "^(Open File|Select a File|Choose wallpaper|Open Folder|Save As|Library|File Upload)(.*)$" }, float = true })
hl.window_rule({ match = { class = ".*telegram.*|wechat" }, float = true })
hl.window_rule({ match = { class = "Emulator" }, float = true })

-- ----------------- General Rules -----------------
hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })

-- ------------------ XWayland Rules -----------------
hl.window_rule({ match = { xwayland = true }, border_color = "rgb(ff5555)" })

-- ------------------ Flameshot Rules ----------------
hl.window_rule({
    match       = { class = "flameshot" },
    no_anim     = true,
    pin         = true,
    float       = true,
    decorate    = false,
    no_blur     = true,
    no_shadow   = true,
    -- A pinned screenshot has to be opaque or you see the desktop through the
    -- thing you just captured.
    opacity     = "1.0 1.0",
})
hl.window_rule({
    match   = { class = "flameshot", title = "flameshot" },
    move    = { 0, 0 },
})
hl.window_rule({
    match = { class = "flameshot", title = "flameshot-pin" },
    move  = { "cursor_x-(window_w*0.5)", "cursor_y-(window_h*0.5)" },
})
