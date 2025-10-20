-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
print( 'Configuring Wezterm...' )

-- disable wayland support cause current bug with wayland
-- will make Wezterm missing titlebar and un-dragable by mouse
config.enable_wayland = false 

-- choose window decoration style
config.window_decorations = "TITLE | RESIZE"

-- disable tab
config.enable_tab_bar = false 

-- select font and font size
config.font = wezterm.font("MesloLGS NF")
config.font_size = 17

-- background opacity 
config.window_background_opacity = 1.0

-- blur background
-- uncomment one of those line when switch between macos and ubuntu
-- config.kde_window_background_blur = true
config.macos_window_background_blur = 90

config.color_scheme = 'Everforest Light (Gogh)' 

config.audible_bell = "Disabled"

config.keys = {
	-- Switch to tab by number (Alt + 1-9)
	{
		key = '1',
		mods = 'ALT',
		action = wezterm.action.ActivateTab(0),
	},
	{
		key = '2',
		mods = 'ALT',
		action = wezterm.action.ActivateTab(1),
	},
	{
		key = '3',
		mods = 'ALT',
		action = wezterm.action.ActivateTab(2),
	},
	{
		key = '4',
		mods = 'ALT',
		action = wezterm.action.ActivateTab(3),
	},
	{
		key = '5',
		mods = 'ALT',
		action = wezterm.action.ActivateTab(4),
	},
	{
		key = '6',
		mods = 'ALT',
		action = wezterm.action.ActivateTab(5),
	},
	{
		key = '7',
		mods = 'ALT',
		action = wezterm.action.ActivateTab(6),
	},
	{
		key = '8',
		mods = 'ALT',
		action = wezterm.action.ActivateTab(7),
	},
	{
		key = '9',
		mods = 'ALT',
		action = wezterm.action.ActivateTab(8),
	},
	
	-- Switch tabs with Alt + Left/Right arrows
	{
		key = 'LeftArrow',
		mods = 'ALT',
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		key = 'RightArrow',
		mods = 'ALT',
		action = wezterm.action.ActivateTabRelative(1),
	},
}

-- and finally, return the configuration to wezterm
return config
