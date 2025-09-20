-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

config.font_size = 14
config.audible_bell = "Disabled"
config.window_decorations = "RESIZE"
-- config.color_scheme = "Kanagawa Dragon (Gogh)"
-- config.color_scheme = "Iceberg (Gogh)"
-- config.color_scheme = "iceberg-dark"
-- config.color_scheme = "Nightfly (Gogh)"
-- config.color_scheme = "Gogh (Gogh)"

config.inactive_pane_hsb = {
	saturation = 0.5,
	brightness = 0.3,
}

config.keys = {
	{
		key = "LeftArrow",
		mods = "CMD",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		key = "RightArrow",
		mods = "CMD",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		key = "[",
		mods = "CMD",
		action = wezterm.action.ActivatePaneDirection("Prev"),
	},
	{
		key = "]",
		mods = "CMD",
		action = wezterm.action.ActivatePaneDirection("Next"),
	},
	{
		key = "d",
		mods = "CMD",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "d",
		mods = "CMD|SHIFT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
}

-- Finally, return the configuration to wezterm:
return config
