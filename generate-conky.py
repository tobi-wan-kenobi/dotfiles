#!/usr/bin/env python

import sys

iconpath = "./conky/"

def inventory_item(cmd, item, pos):
    result = "{}${{image {}boxed_{}.png -s 64x64 -p {}}}".format(cmd, iconpath, item, pos)
    result += "${else}"
    result += "${{image {}empty_box.png -s 64x64 -p {}}}${{endif}}".format(iconpath, pos)
    return result

def select_item(cmd, vrange, icons, pos):
    result = ""
    intvl = (vrange[1] - vrange[0])/(len(icons)-1)
    value = intvl
    for icon in icons[0:len(icons)-1]:
        result += "${{if_match ${{{}}} < {}}}".format(cmd, value)
        result += "${{image {}{}.png -s 64x64 -p {}}}".format(iconpath, icon, pos)
        result += "${else}"
        value += intvl
    result += "${{image {}{}.png -s 64x64 -p {}}}".format(iconpath, icons[-1], pos)
    result += "".join("${endif}"*(len(icons)-1))

    return result

def generate_inventory():
    result = ""
    result += inventory_item("${if_match \"${exec cat /sys/class/power_supply/BAT0/status}\" != \"Discharging\"}", "battery", "0,122")
    result += inventory_item("${if_up wlp2s0}", "wlan", "64,122")
    result += inventory_item("${if_up eno1}", "lan", "128,122")
    result += select_item("memperc", [ 0, 100 ], [ "empty_box", "boxed_gameboy", "boxed_nes", "boxed_snes", "boxed_n64", "boxed_wii" ], "192,122")

    return result

def generate_bar(command, yoff, iconset, vrange, num_icons, xoff=0):
    result = ""

    states = num_icons*(len(iconset)-1)
    intvl = (vrange[1] - vrange[0])/states
    value = intvl
    while num_icons > 0:
        for icon in iconset[0:len(iconset)-1]:
            result += "${{if_match ${{{}}} < {}}}".format(command, value)
            result += "${{image {}{}.png -s 32x32 -p {},{}}}".format(iconpath, icon, xoff, yoff)
            result += "${else}"
            value += intvl
        result += "${{image {}{}.png -s 32x32 -p {},{}}}".format(iconpath, iconset[-1], xoff, yoff)
        for icon in iconset[0:len(iconset)-1]:
            result += "${endif}"
        xoff += 32
        num_icons -= 1

    return result

header = """
conky.config = {
	background=true,
	update_interval=1,
	double_buffer=true,
	own_window=true,
	own_window_type=normal,
	own_window_transparent=false,
	own_window_hints="undecorated,below,sticky,skip_taskbar,skip_pager",
	own_window_argb_visual=true,
	own_window_argb_value=220,
	out_to_console=false,
	xftalpha=1,
	use_xft=true,
	font="Terminus:size=13:bold",
	default_color="#657b83",
	alignment="middle_left",
        gap_x=560,
	minimum_width=800,
}
"""

body = """${{color {lifecolor}}}-LIFE-{batterystatus}${{color}}${{alignr 0}}${{tztime}}
${{alignr 0}}-PRESS START-   
${{alignr 0}}${{color {coincolor}}}{coinfont}${{image {iconpath}/coin.png -s 16x16 -p {coinx}, 38}}${{exec cat /proc/uptime|cut -d' ' -f1}}${{font}}    
${{color {powercolor}}}-POWER-{cpustatus}${{color}}


${{voffset -6}}${{color {inventorycolor}}}-INVENTORY-{inventory}${{color}}


${{image {iconpath}/progress_left.png -s 16x30 -p 0,200}}{networkdownspeed}${{image {iconpath}/progress_right.png -s 16x30 -p 370,200}}
${{image {iconpath}/progress_left.png -s 16x30 -p 0,235}}{networkupspeed}${{image {iconpath}/progress_right.png -s 16x30 -p 370,235}}





${{alignc}}${{if_updatenr 2}}-READY PLAYER 1-${{endif}}
"""



print header
print "conky.text = [[\n{}\n]]\n".format(body.format(
    iconpath=iconpath,
    lifecolor="#ff0900", batterystatus=generate_bar("battery_percent", 18, [ "heart_empty", "heart_half", "heart_full" ], [ 0, 99 ], 8),
    powercolor="#02ffff", cpustatus=generate_bar("cpu", 70, [ "blue_capsule_empty", "blue_capsule" ], [ 0, 99 ], 8),
    coinx=650, coincolor="#f8f800", coinfont="${font Terminus:size=14:bold}",
    inventorycolor="#ffbb00", inventory=generate_inventory(),
    networkdownspeed=generate_bar("downspeedf wlp2s0", 200, [ "network_empty", "network"], [ 0, 2*1024 ], 11, xoff=16),
    networkupspeed=generate_bar("upspeedf wlp2s0", 235, [ "network_empty", "networkup"], [ 0, 512 ], 11, xoff=16),
))
