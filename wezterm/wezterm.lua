local wezterm = require("wezterm")
local act = wezterm.action
local config = {}

config.color_scheme = "Gruvbox dark, hard (base16)"
-- calt=0 means ligatures-disabled
config.harfbuzz_features = { "calt=0" }
config.window_background_opacity = 1.0
config.window_decorations = "TITLE | RESIZE"
config.scrollback_lines = 3000
config.xcursor_theme = "breeze_cursors"

config.font = wezterm.font_with_fallback({
    "JetBrains Mono",
    "Noto Sans CJK HK",
    "Noto Sans CJK SC",
    "Noto Sans CJK JP",
    "Noto Color Emoji",
})
config.font_size = 11.5

config.initial_cols = 110
config.initial_rows = 32

-- Tab bar
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.tab_max_width = 16
config.tab_bar_at_bottom = true

config.status_update_interval = 300
config.enable_wayland = true

-- tmux
-- config.default_prog = { "/bin/zsh", "-l", "-c", "tmux attach || tmux" },

config.warn_about_missing_glyphs = false
config.hyperlink_rules = wezterm.default_hyperlink_rules()


-- Keybindings
-- Keys
config.leader = { key = "a", mods = "ALT", timeout_milliseconds = 1000 }
config.keys = {
    -- Send C-a when pressing C-a twice
    { key = "a", mods = "LEADER",       action = act.SendKey { key = "a", mods = "ALT" } },
    { key = "c", mods = "LEADER",       action = act.ActivateCopyMode },

    -- Pane keybindings
    { key = "-", mods = "LEADER",       action = act.SplitVertical { domain = "CurrentPaneDomain" } },
    -- SHIFT is for when caps lock is on
    { key = "|", mods = "LEADER|SHIFT", action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
    { key = "h", mods = "LEADER",       action = act.ActivatePaneDirection("Left") },
    { key = "j", mods = "LEADER",       action = act.ActivatePaneDirection("Down") },
    { key = "k", mods = "LEADER",       action = act.ActivatePaneDirection("Up") },
    { key = "l", mods = "LEADER",       action = act.ActivatePaneDirection("Right") },
    { key = "x", mods = "LEADER",       action = act.CloseCurrentPane { confirm = true } },
    { key = "z", mods = "LEADER",       action = act.TogglePaneZoomState },
    { key = "s", mods = "LEADER",       action = act.RotatePanes "Clockwise" },
    -- We can make separate keybindings for resizing panes
    -- But Wezterm offers custom "mode" in the name of "KeyTable"
    { key = "r", mods = "LEADER",       action = act.ActivateKeyTable { name = "resize_pane", one_shot = false } },

    -- Tab keybindings
    { key = "n", mods = "LEADER",       action = act.SpawnTab("CurrentPaneDomain") },
    { key = "[", mods = "LEADER",       action = act.ActivateTabRelative(-1) },
    { key = "]", mods = "LEADER",       action = act.ActivateTabRelative(1) },
    { key = "t", mods = "LEADER",       action = act.ShowTabNavigator },
    -- Key table for moving tabs around
    { key = "m", mods = "LEADER",       action = act.ActivateKeyTable { name = "move_tab", one_shot = false } },


    -- Lastly, workspace
    { key = "w", mods = "LEADER",       action = act.ShowLauncherArgs { flags = "FUZZY|WORKSPACES" } },

}

for i = 1, 9 do
    table.insert(config.keys, {
        key = tostring(i),
        mods = "LEADER",
        action = act.ActivateTab(i - 1)
    })
end

config.key_tables = {
    resize_pane = {
        { key = "h",      action = act.AdjustPaneSize { "Left", 1 } },
        { key = "j",      action = act.AdjustPaneSize { "Down", 1 } },
        { key = "k",      action = act.AdjustPaneSize { "Up", 1 } },
        { key = "l",      action = act.AdjustPaneSize { "Right", 1 } },
        { key = "Escape", action = "PopKeyTable" },
        { key = "Enter",  action = "PopKeyTable" },
    },
    move_tab = {
        { key = "h",      action = act.MoveTabRelative(-1) },
        { key = "j",      action = act.MoveTabRelative(-1) },
        { key = "k",      action = act.MoveTabRelative(1) },
        { key = "l",      action = act.MoveTabRelative(1) },
        { key = "Escape", action = "PopKeyTable" },
        { key = "Enter",  action = "PopKeyTable" },
    }
}

return config
