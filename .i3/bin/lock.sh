#!/usr/bin/env bash

# adapted from the solutions found in
# https://www.reddit.com/r/unixporn/comments/3358vu/i3lock_unixpornworthy_lock_screen/

icon="$HOME/.i3/images/lock.png"
tmpfile="$HOME/.i3/images/.tmplock.png"

scrot -m "$tmpfile"
convert "$tmpfile" -scale 10% -scale 1000% "$tmpfile"

image_size=$(identify "$icon" | grep -o '[0-9]*x[0-9]*' | head -n 1)
image_width=$(echo "$image_size" | cut -d'x' -f1)
image_height=$(echo "$image_size" | cut -d'x' -f2)

for res in $(xrandr -q | grep ' connected' | cut -d' ' -f3); do
	screen_x=$(echo $res | cut -d'x' -f1)
	screen_y=$(echo $res | cut -d'x' -f2 | cut -d'+' -f1)
	off_x=$(echo $res | cut -d'x' -f2 | cut -d'+' -f2)
	off_y=$(echo $res | cut -d'x' -f2 | cut -d'+' -f3)

	x=$(($off_x + $screen_x/2 - $image_width/2))
	y=$(($off_y + $screen_y/2 - $image_height/2))

	convert "$tmpfile" "$icon" -geometry "+$x+$y" -composite -matte "$tmpfile"
done

i3lock -i "$tmpfile"
rm "$tmpfile"
