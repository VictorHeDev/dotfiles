-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}
local act = wezterm.action

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.font = wezterm.font_with_fallback({
	"JetBrains Mono",
	"Noto Color Emoji",
})
config.font_size = 12.0

-- Set theme
-- config.color_scheme = "Catppuccin Macchiato"
-- config.color_scheme = "Dracula+"
config.color_scheme = "Tokyo Night"

config.scrollback_lines = 200000
config.tab_max_width = 24
config.use_dead_keys = false
config.window_decorations = "RESIZE" -- no title bar
config.window_close_confirmation = "AlwaysPrompt"
config.window_background_opacity = 0.97

-- Dim inactive panes
config.inactive_pane_hsb = {
	saturation = 0.24,
	brightness = 0.5,
}

-- and finally, return the configuration to wezterm
return config
