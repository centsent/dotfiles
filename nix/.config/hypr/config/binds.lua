local mainMod = "SUPER"

-- Core Actions
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + D", hl.dsp.focus({ workspace = "previous" }))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
-- hl.bind(mainMod .. " + Tab", hl.dsp.cyclenext())
hl.bind(mainMod .. " + CTRL + SHIFT + B", hl.dsp.exec_cmd("killall -SIGUSR1 waybar"))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd(notificationCenter))

-- Applications
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + CTRL + X", hl.dsp.exec_cmd(logout))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd("flameshot gui"))
hl.bind(mainMod .. " + CTRL + SHIFT + A", hl.dsp.exec_cmd("flameshot gui --clipboard"))

-- Window Management
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Workspace Navigation
hl.bind(mainMod .. " + CTRL + H", hl.dsp.focus({ workspace = "-1" }))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.focus({ workspace = "+1" }))

for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Window Focus
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.focus({ direction = "d" }))

-- Mouse Controls
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Media Controls
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"),
	{ locked = true, repeating = true }
)

-- System Management
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd(scriptsDir .. "/reload.sh"))

-- Flameshot PrintScreen binding
hl.bind("Print", function()
    local mon = hl.get_active_monitor()
    local n = mon and mon.id or 0
    hl.exec_cmd("flameshot screen --number " .. n .. " --edit")
end)
