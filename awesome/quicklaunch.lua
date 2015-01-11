return {
    m = {
        func = function()
            awful.util.spawn_with_shell(terminal ..
              " -c mutt -t mutt -e $HOME/dotfiles/mail/start-mutt.sh")
        end,
        info = "mutt"
    },
    d = {
        func = function()
            awful.util.spawn("dwb")
        end,
        info = "dwb"
    },
    c = {
        func = function()
            awful.util.spawn("chromium")
        end,
        info = "chromium"
    },
    i = {
        func = function()
            awful.util.spawn("inkscape")
        end,
        info = "inkscape"
    },
    g = {
        func = function()
            awful.util.spawn("gimp")
        end,
        info = "gimp"
    },
    s = {
        func = function()
            awful.util.spawn_with_shell("STEAM_FORCE_CLOSE=1 steam")
        end,
        info = "steam"
    },
    a = {
        func = function()
            awful.util.spawn_with_shell("aseprite")
        end,
        info = "aseprite"
    },
    l = {
        func = function()
            awful.util.spawn_with_shell("lmms")
        end,
        info = "lmms"
    },
    t = {
        func = function()
            awful.util.spawn_with_shell("tiled")
        end,
        info = "tiled"
    }
}
