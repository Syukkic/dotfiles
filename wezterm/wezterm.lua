local wezterm = require("wezterm")
local config = {
	color_scheme = "Gruvbox dark, hard (base16)",
	-- calt=0 means ligatures-disabled
	harfbuzz_features = { "calt=0" },
	window_background_opacity = 1,
	font = wezterm.font_with_fallback({
		"JetBrains Mono",
		"Noto Sans CJK HK",
		"Noto Sans CJK SC",
		"Noto Sans CJK JP",
		"Noto Color Emoji",
	}),
	font_size = 10.0,
	enable_tab_bar = true,
	enable_wayland = true,
	-- default_prog = { "/bin/zsh", "-l", "-c", "tmux attach || tmux" },

	warn_about_missing_glyphs = false,
	hyperlink_rules = wezterm.default_hyperlink_rules(),
}

return config
