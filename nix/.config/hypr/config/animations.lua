hl.config({
    animations = {
        enabled = true,
    }
})

hl.curve("linear", { type = "bezier", points = { {0, 0}, {1, 1} } })
hl.curve("md3_standard", { type = "bezier", points = { {0.2, 0}, {0, 1} } })
hl.curve("md3_decel", { type = "bezier", points = { {0.05, 0.7}, {0.1, 1} } })
hl.curve("md3_accel", { type = "bezier", points = { {0.3, 0}, {0.8, 0.15} } })
hl.curve("overshot", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.1} } })
hl.curve("crazyshot", { type = "bezier", points = { {0.1, 1.5}, {0.76, 0.92} } })
hl.curve("hyprnostretch", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.0} } })
hl.curve("menu_decel", { type = "bezier", points = { {0.1, 1}, {0, 1} } })
hl.curve("menu_accel", { type = "bezier", points = { {0.38, 0.04}, {1, 0.07} } })
hl.curve("easeInOutCirc", { type = "bezier", points = { {0.85, 0}, {0.15, 1} } })
hl.curve("easeOutCirc", { type = "bezier", points = { {0, 0.55}, {0.45, 1} } })
hl.curve("easeOutExpo", { type = "bezier", points = { {0.16, 1}, {0.3, 1} } })
hl.curve("softAcDecel", { type = "bezier", points = { {0.26, 0.26}, {0.15, 1} } })
hl.curve("md2", { type = "bezier", points = { {0.4, 0}, {0.2, 1} } })

-- Tuned for glide over snap. Durations are broadly unchanged, so nothing feels
-- less responsive than before; what changed is the easing and the window entry
-- scale. `popin 60%` starts a window at 60% of its size, which is a big enough
-- jump to read as a pop; at 88% the same motion is a settle instead.
--
-- softAcDecel eases in and out gently, so entrances have no hard edge at either
-- end. easeOutExpo covers most of its distance early then coasts, which is what
-- makes a workspace slide feel like it glides to a stop rather than halting.
hl.animation({ leaf = "windows", enabled = true, speed = 3.5, bezier = "softAcDecel", style = "popin 88%" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 3.5, bezier = "softAcDecel", style = "popin 88%" })
-- Exits keep an accelerating curve: leaving should get out of the way quickly.
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "md3_accel", style = "popin 88%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "easeOutExpo" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.5, bezier = "softAcDecel" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 3, bezier = "softAcDecel", style = "slide" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 2, bezier = "menu_accel" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 2, bezier = "softAcDecel" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 4.5, bezier = "menu_accel" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "easeOutExpo", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3.5, bezier = "softAcDecel", style = "slidevert" })
