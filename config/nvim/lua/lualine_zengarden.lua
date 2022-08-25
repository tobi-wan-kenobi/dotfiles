local colors = {
  fg           = '#faebd7',
  darkfg       = '#d2c4b0',
  bg           = '#353839',
  black        = '#353839',
  white        = '#f4ece2',
  red          = '#d94070',
  green        = '#378c5d',
  blue         = '#477ab7',
  yellow       = '#b38a32',
  magenta      = '#8d348c',
  orange       = '#e05b1f',
  cyan         = '#377c8b',
  gray         = '#505354',
  darkgray     = '#444748',
  lightgray    = '#5c5f60',
  inactivegray = '#686b6c',
}
return {
  normal = {
    a = {bg = colors.gray, fg = colors.fg},
    b = {bg = colors.darkfg, fg = colors.black},
    c = {bg = colors.black, fg = colors.darkfg}
  },
  insert = {
    a = {bg = colors.yellow, fg = colors.black},
    b = {bg = colors.darkfg, fg = colors.black},
    c = {bg = colors.black, fg = colors.darkfg}
  },
  visual = {
    a = {bg = colors.magenta, fg = colors.black},
    b = {bg = colors.darkfg, fg = colors.black},
    c = {bg = colors.black, fg = colors.darkfg}
  },
  replace = {
    a = {bg = colors.red, fg = colors.black},
    b = {bg = colors.darkfg, fg = colors.black},
    c = {bg = colors.black, fg = colors.darkfg}
  },
  command = {
    a = {bg = colors.green, fg = colors.black},
    b = {bg = colors.darkfg, fg = colors.black},
    c = {bg = colors.black, fg = colors.darkfg}
  },
  inactive = {
    a = {bg = colors.black, fg = colors.darkfg},
    b = {bg = colors.black, fg = colors.darkfg},
    c = {bg = colors.black, fg = colors.darkfg}
  }
}

