-- Pull in the wezterm API
local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.font_size = 14
config.background = {
  {
    source = {
      Color = '#000000'
    },
    opacity = 0.90,
    width = '100%',
    height = '100%'
  },
  {
    source = {
      File = os.getenv('HOME') .. '/.config/wezterm/JulianJLogo_White.png'
    },
    opacity = 0.05,
    height = 'Contain',
    width = 'Contain',
    repeat_x = 'NoRepeat',
    repeat_y = 'NoRepeat',
    vertical_align = 'Middle',
    horizontal_align = 'Center',
  }
}
config.window_decorations = "RESIZE"
config.use_dead_keys = false
config.scrollback_lines = 5000
config.adjust_window_size_when_changing_font_size = false
config.hide_tab_bar_if_only_one_tab = true
config.disable_default_key_bindings = true
config.leader = { key = 'b', mods = 'CMD', timeout_milliseconds = 2000 }
config.keys = {
  { key = 'l',     mods = 'CMD|SHIFT',  action = act.ActivateTabRelative(1) },
  { key = 'h',     mods = 'CMD|SHIFT',  action = act.ActivateTabRelative(-1) },
  { key = 'j',     mods = 'CMD',        action = act.ActivatePaneDirection 'Down' },
  { key = 'k',     mods = 'CMD',        action = act.ActivatePaneDirection 'Up' },
  { key = 'Enter', mods = 'CMD',        action = act.ActivateCopyMode },
  { key = 'R',     mods = 'SHIFT|CTRL', action = act.ReloadConfiguration },
  { key = '=',     mods = 'CTRL',       action = act.IncreaseFontSize },
  { key = '-',     mods = 'CTRL',       action = act.DecreaseFontSize },
  { key = '0',     mods = 'CTRL',       action = act.ResetFontSize },
  { key = 'C',     mods = 'SHIFT|CTRL', action = act.CopyTo 'Clipboard' },
  { key = 'N',     mods = 'SHIFT|CTRL', action = act.SpawnWindow },
  {
    key = 'U',
    mods = 'SHIFT|CTRL',
    action = act.CharSelect {
      copy_on_select = true,
      copy_to = 'ClipboardAndPrimarySelection'
    }
  },
  { key = 'v',          mods = 'CMD',         action = act.PasteFrom 'Clipboard' },
  { key = 'PageUp',     mods = 'CTRL',        action = act.ActivateTabRelative(-1) },
  { key = 'PageDown',   mods = 'CTRL',        action = act.ActivateTabRelative(1) },
  { key = 'LeftArrow',  mods = 'SHIFT|CTRL',  action = act.ActivatePaneDirection 'Left' },
  { key = 'RightArrow', mods = 'SHIFT|CTRL',  action = act.ActivatePaneDirection 'Right' },
  { key = 'UpArrow',    mods = 'SHIFT|CTRL',  action = act.ActivatePaneDirection 'Up' },
  { key = 'DownArrow',  mods = 'SHIFT|CTRL',  action = act.ActivatePaneDirection 'Down' },
  { key = 'f',          mods = 'CMD',         action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'd',          mods = 'CMD',         action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'h',          mods = 'CMD',         action = act.ActivatePaneDirection 'Left' },
  { key = 'l',          mods = 'CMD',         action = act.ActivatePaneDirection 'Right' },
  { key = 't',          mods = 'CMD',         action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'w',          mods = 'CMD',         action = act.CloseCurrentTab { confirm = false } },
  { key = 'x',          mods = 'CMD',         action = act.CloseCurrentPane { confirm = false } },
  { key = 'b',          mods = 'LEADER|CTRL', action = act.SendString '\x02' },
  { key = 'Enter',      mods = 'LEADER',      action = act.ActivateCopyMode },
  { key = 'p',          mods = 'LEADER',      action = act.PasteFrom 'PrimarySelection' },
  {
    key = 'k',
    mods = 'CTRL|ALT',
    action = act.Multiple {
      act.ClearScrollback 'ScrollbackAndViewport',
      act.SendKey { key = 'L', mods = 'CTRL' }
    }
  },
  {
    key = 'r',
    mods = 'LEADER',
    action = act.ActivateKeyTable {
      name = 'rezise_pane',
      one_shot = false
    }
  },
  { key = 'F', mods = 'SHIFT|CTRL', action = act.Search { Regex = '' } },
}

wezterm.on('gui-startup', function()
  local tab, pane, window = mux.spawn_window({})
  local windowHeight = wezterm.gui.screens().main.height
  local windowWidth = wezterm.gui.screens().main.width / 2
  window:gui_window():set_inner_size(windowWidth, windowHeight)
  window:gui_window():set_position(windowWidth, 0)
end)

-- and finally, return the configuration to wezterm
return config
