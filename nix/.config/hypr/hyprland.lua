require("config.variables")
require("config.env")
require("config.monitors")
require("config.input")
require("config.general")
require("config.decoration")
require("config.animations")
require("config.gestures")
require("config.layout")
require("config.rules")
require("config.binds")
require("config.exec")

hl.config({
    misc = {
        force_default_wallpaper = -1,
    },
})

hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})
