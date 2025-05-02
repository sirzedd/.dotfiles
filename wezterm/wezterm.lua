local wezterm = require("wezterm")




config = wezterm.config_builder()

config = {
	automatically_reload_config = true,
	enable_tab_bar = false,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE", -- disable the title bar but enable the resizable border
	default_cursor_style = "BlinkingBar",
  color_scheme = "Molokai",
  -- hyperlink click rules
  hyperlink_rules = wezterm.default_hyperlink_rules(),
  mouse_bindings = {
    -- CMD-click will open the link under the mouse cursor
    {
      event = { Up = { streak = 1, button = "Left" } },
      mods = "SUPER",
      action = wezterm.action.OpenLinkAtMouseCursor,
    },
  },
	--color_scheme = "tokyonight_night",
	--color_scheme = "Tokyo Night",
	--color_scheme = "Nord (Gogh)",
	-- font = wezterm.font("JetBrains Mono", { weight = "Bold" }),
	-- font = wezterm.font 'Fira Mono'
	font = wezterm.font("FiraCode Nerd Font Propo", {weight="Regular", stretch="Normal", style="Normal"}),
	font_size = 12.5,
}

return config
