local wezterm = require("wezterm")
local config = {
    color_scheme = "Gruvbox dark, medium (base16)";
    window_background_opacity = 0.9;
    -- font = wezterm.font("Fira Code Nerd Font");
    font = wezterm.font_with_fallback {
        "Fira Code Nerd Font",
        "Cascadia Code",
        "Nerd Font"
    };
    font_size = 10.5;
    enable_tab_bar = false;
    default_prog = { '/bin/zsh', '-l', '-c', 'tmux attach || tmux' };

    hyperlink_rules = wezterm.default_hyperlink_rules();
}


return config