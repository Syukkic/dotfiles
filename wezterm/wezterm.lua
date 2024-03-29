local wezterm = require("wezterm")
local config = {
	color_scheme = "Gruvbox dark, hard (base16)",
	-- color_scheme = "Vs Code Dark+ (Gogh)",
	-- calt=0 means ligatures-disabled
	harfbuzz_features = { "calt=0" },
	window_background_opacity = 0.9,
	font = wezterm.font_with_fallback({
		"JetBrains Mono",
		"Noto Color Emoji",
		"Source Han Sans SC",
		"Source Han Sans TC",
	}),
	font_size = 10.5,
	enable_tab_bar = false,
	-- default_prog = { "/bin/zsh", "-l", "-c", "tmux attach || tmux" },

	warn_about_missing_glyphs = false,

	hyperlink_rules = wezterm.default_hyperlink_rules(),
}

return config
