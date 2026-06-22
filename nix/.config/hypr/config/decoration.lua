hl.config({
    decoration = {
        dim_special = 0.2,
        rounding = 6,

        active_opacity = 1,
        inactive_opacity = 1,

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
