#!/bin/bash

DIR=$HOME/wallpapers/background
PICS=($(find ${DIR} -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" \)))
RANDOMPICS=${PICS[ $RANDOM % ${#PICS[@]} ]}

change_swaybg(){
  pkill swww
  pkill swaybg
  swaybg -m fill -i ${RANDOMPICS}
}

change_swww(){
  pkill swaybg
  swww query || swww init
  swww img ${RANDOMPICS} --transition-fps 60 --transition-type wipe --transition-duration 2.0
}

change_current(){
  if pidof swaybg >/dev/null; then
    change_swaybg
  else
    change_swww
  fi
}

switch(){
  if pidof swaybg >/dev/null; then
    change_swww
  else
    change_swaybg
  fi
}

case "$1" in
	"swaybg")
		change_swaybg
		;;
	"swww")
		change_swww
		;;
  "s")
		switch
		;;
	*)
		change_current
		;;
esac