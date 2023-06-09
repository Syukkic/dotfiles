local wezterm = require("wezterm")
return {
    color_scheme = "Gruvbox dark, medium (base16)",
    window_background_opacity = 0.9,
    font = wezterm.font("Fira Code Nerd Font"),
    font_size = 10.5,
    enable_tab_bar = false,
    default_prog = { '/bin/bash', '-l', '-c', 'tmux attach || tmux' },
}

