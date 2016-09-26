#!/bin/bash
old_dir="`pwd`/`basename "$0"`"
old_dir=`dirname "$old_dir"`
cd "`dirname "$0"`"
script_dir="`pwd`/`basename "$0"`"
script_dir=`dirname "$script_dir"`

xrandr --screen 0 --fb 2390x768 --output VGA-1-0 --mode 1024x768 --rate 60 --output LVDS-1-0 --mode 1366x768 --rate 60 --right-of VGA-1-0

echo -e "\nPress <ENTER> to continue"
read OS
