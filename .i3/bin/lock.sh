#!/usr/bin/env bash

# adapted from the solutions found in
# https://www.reddit.com/r/unixporn/comments/3358vu/i3lock_unixpornworthy_lock_screen/

tmpfile="$HOME/.i3/images/.tmplock.png"

scrot -m "$tmpfile"
convert "$tmpfile" -scale 10% -scale 1000% "$tmpfile"

i3lock -i "$tmpfile"
rm "$tmpfile"
