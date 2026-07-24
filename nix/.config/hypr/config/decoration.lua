hl.config({
    decoration = {
        dim_special = 0.2,
        rounding = 6,

        -- Global window transparency. This used to live as a catch-all `.*`
        -- window rule in rules.lua; as a decoration default it is easier to
        -- reason about, because per-app rules cleanly override it rather than
        -- competing with another rule of the same specificity.
        active_opacity = 0.90,
        inactive_opacity = 0.80,

        -- Fullscreen is almost always video or a game, where showing the
        -- desktop through the window reads as a rendering fault.
        fullscreen_opacity = 1.0,

        shadow = {
            enabled = true,
            range = 50,
            offset = { 20, 20 },
            render_power = 3,
            scale = 0.9,
        },

        blur = {
            enabled = true,
            size = 2,
            passes = 4,
            new_optimizations = true,
            vibrancy = 0.1000,
            ignore_opacity = true,
        }
    },
    group = {
        groupbar = {
            col = {
                active = { colors = {"rgb(bd93f9)", "rgb(44475a)"}, angle = 90 },
                inactive = "rgba(282a36dd)",
            }
        }
    }
})
