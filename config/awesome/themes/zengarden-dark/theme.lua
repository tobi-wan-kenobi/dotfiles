---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local gears = require("gears")
local naughty = require("naughty")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_configuration_dir() .. "/themes/"

local colors = {
	fg = "#e0d1be",
	bg = "#353839",
	bglight = "#393c3d",
	fg3 = "#d2c4b0",
	fglight = "#f4ece2",
	bglight = "#444748",
	red = "#d94070",
	green = "#378c5d",
	yellow = "#b38a32",
	blue = "#477ab7",
	purple = "#8d68b1",
	aqua = "#3398a9",
	gray = "#c4b6a3",
	lightgray = "#686b6c",
	orange = "#ff7639",
	lightblue = "#6493d3",
}

local theme = {}

theme.font          = "Ubuntu Medium 12"

theme.bg_normal     = colors.bg
theme.bg_focus      = colors.gray
theme.bg_urgent     = colors.yellow
theme.bg_minimize   = colors.blue
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = colors.fg
theme.fg_focus      = colors.bg
theme.fg_urgent     = colors.bg
theme.fg_minimize   = colors.bg

theme.useless_gap   = dpi(5)
theme.border_width  = dpi(0)
theme.border_normal = colors.bglight
theme.border_focus  = colors.gray
theme.border_marked = colors.yellow

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

theme.taglist_font = "FontAwesome 12"

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = dpi(25)
theme.menu_width  = dpi(150)

theme.wallpaper = themes_path.."zengarden-dark/background.png"

theme.layout_fairh = themes_path.."zengarden-dark/layouts/fairhw.png"
theme.layout_fairv = themes_path.."zengarden-dark/layouts/fairvw.png"
theme.layout_floating  = themes_path.."zengarden-dark/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."zengarden-dark/layouts/magnifierw.png"
theme.layout_max = themes_path.."zengarden-dark/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."zengarden-dark/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."zengarden-dark/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."zengarden-dark/layouts/tileleftw.png"
theme.layout_tile = themes_path.."zengarden-dark/layouts/tilew.png"
theme.layout_tiletop = themes_path.."zengarden-dark/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."zengarden-dark/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."zengarden-dark/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."zengarden-dark/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."zengarden-dark/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."zengarden-dark/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."zengarden-dark/layouts/cornersew.png"

theme.awesome_icon = theme_assets.awesome_icon(
	theme.menu_height, theme.bg_focus, theme.fg_focus
)

theme.icon_theme = "Papirus-Dark"

-- notifications
theme.notification_font = theme.font
theme.notification_bg = colors.lightblue
theme.notification_fg = colors.bg
theme.notification_border_width = dpi(0)
theme.notification_border_color = colors.blue
theme.notification_shape = gears.shape.rounded_rect
theme.notification_opacity = 0.6
theme.notification_margin = dpi(2)
theme.notification_width = dpi(240)
theme.notification_height = dpi(100)
theme.notification_spacing = dpi(2) 

naughty.config.presets.critical.bg = colors.red
naughty.config.presets.critical.fg = colors.bg

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
