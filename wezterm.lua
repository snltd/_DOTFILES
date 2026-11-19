local wezterm = require 'wezterm'

local on_mac = wezterm.target_triple:find('darwin')
local insert_key = on_mac and '\u{f746}' or 'Insert'
local link_action_key = on_mac and 'CMD' or 'CTRL'

local light_theme = 'Catppuccin Latte'
-- local light_theme = 'Solarized Light (Gogh)'
-- local dark_theme = 'Solarized Dark (Gogh)'

local function scheme_for_appearance(appearance)
  return light_theme
end

local config = wezterm.config_builder()

config.mouse_bindings = {
  { -- Plain left-click only selects text, does NOT open links
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = wezterm.action.CompleteSelection 'ClipboardAndPrimarySelection',
  },
  { -- Ctrl+click opens the link
    event = { Up = { streak = 1, button = 'Left' } },
    mods = link_action_key,
    action = wezterm.action.OpenLinkAtMouseCursor,
  },
  { -- Disable the Down event for Ctrl+click to avoid odd behaviour
    event = { Down = { streak = 1, button = 'Left' } },
    mods = link_action_key,
    action = wezterm.action.Nop,
  },
}

config.keys = {
  {
    key = insert_key,
    mods = 'CTRL|SHIFT',
    action = wezterm.action.PasteFrom 'Clipboard',
  },
  {
    key = '\u{f746}',
    mods = 'SHIFT',
    action = wezterm.action.PasteFrom 'PrimarySelection',
  },
  { key = 'UpArrow',   mods = 'CTRL|SHIFT', action = wezterm.action.ScrollToPrompt(-1) },
  { key = 'DownArrow', mods = 'CTRL|SHIFT', action = wezterm.action.ScrollToPrompt(1) },
}

config.audible_bell = 'Disabled'
config.scrollback_lines = 5000

config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())

config.front_end = on_mac and 'WebGpu' or 'OpenGL'
config.webgpu_power_preference = 'HighPerformance'
config.underline_thickness = '1.5pt'
config.default_cursor_style = 'SteadyUnderline'
config.max_fps = 255

config.font = on_mac and wezterm.font "FiraCode Nerd Font Mono" or wezterm.font 'Berkeley Mono'
config.font_size = on_mac and 18.0 or 16.3
config.line_height = 1.0
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.tab_max_width = 32
config.use_fancy_tab_bar = false

config.window_padding = {
  left = 0,
  right = 0,
  top = 10,
  bottom = 7.5,
}
config.adjust_window_size_when_changing_font_size = false
config.window_close_confirmation = 'NeverPrompt'
config.inactive_pane_hsb = {
  saturation = .8,
  brightness = .8,
}

--  enables undercurl locally
config.set_environment_variables = {
  TERM = 'wezterm',
}

return config
